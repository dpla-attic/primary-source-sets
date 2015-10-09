require 'rails_helper'

RSpec.configure do |c|
  c.infer_base_class_for_anonymous_controllers = false
end

describe ApplicationController, type: :controller do

  describe '#create_transcoding_job' do
    let(:response) { double }
    let(:response_body) { { 'id' => 123 } }

    before do
      allow(Zencoder::Job).to receive(:create).and_return(response)
      allow(response).to receive(:body).and_return(response_body)
      # TODO: shared contexts for the Zencoder credentials
      allow(Settings).to receive_message_chain(:zencoder, :s3_credentials_name)
                     .and_return(false)
      allow(Settings).to receive_message_chain(:zencoder, :api_key)
                     .and_return('a')
    end

    context 'with job options' do
      before do
        allow(subject).to receive(:input_location).and_return('loc')
        allow(subject).to receive(:transcoding_outputs).and_return(['o'])
        allow(subject).to receive(:transcoding_notifications).and_return(['n'])
        allow(response).to receive(:code).and_return('201')
      end

      context 'without Zencoder named credentials' do
        it 'calls Zencoder::Job with the correct options' do
          opts = { input: 'loc', outputs: ['o'], notifications: ['n'] }
          expect(Zencoder::Job).to receive(:create)
                               .with(opts)
                               .and_return(response)
          subject.create_transcoding_job('a', 'b', {})
        end
      end

      context 'with Zencoder named credentials' do
        before do
          allow(Settings).to receive_message_chain(:zencoder,
                                                   :s3_credentials_name)
                         .and_return('production')
        end
        it 'calls Zencoder::Job with the correct options' do
          opts = { input: 'loc', outputs: ['o'], notifications: ['n'],
                   credentials: 'production' }
          expect(Zencoder::Job).to receive(:create)
                               .with(opts)
                               .and_return(response)
          subject.create_transcoding_job('a', 'b', {})
        end
      end
    end

    it 'logs the job creation' do
      allow(response).to receive(:code).and_return('201')
      msg = "Creating job with: {:input=>\"s3://" \
            "#{Settings.aws.s3_upload_bucket}/a\", :outputs=>[], " \
            ":notifications=>[\"http://zencoderfetcher/\"]}"
      expect(Rails.logger).to receive(:info).with(msg)
      subject.create_transcoding_job('a', 'b', {})
    end

    it 'returns a String job ID' do
      allow(response).to receive(:code).and_return('201')
      expect(subject.create_transcoding_job('a', 'b', {})).to eq('123')
    end
  end

  describe '#create_notification' do
    let(:remote_addr) { '192.168.0.2' }
    let(:outputs) { ['a'] }
    let(:video) { create(:video_factory) }
    let(:video_with_nil_meta) { create(:video_with_nil_meta_factory) }
    let(:params1) do
      {
        job: { id: '1', state: 'finished' },
        outputs: ['a']
      }
    end
    let(:params2) do
      {
        job: { id: '2', state: 'finished' }
      }
    end
    let(:params99) do
      {
        job: { id: '99', state: 'finished' }
      }
    end

    controller VideoNotificationsController do
      def create
        create_notification(Video)
      end
    end

    include ZencoderAuthHelper

    before do
      allow(Video).to receive(:find_by_transcoding_job)
                  .with('1')
                  .and_return(video)
      allow(Video).to receive(:find_by_transcoding_job)
                  .with('2')
                  .and_return(video_with_nil_meta)
      allow(Video).to receive(:find_by_transcoding_job)
                  .with('99')
                  .and_return(nil)
      @request.env['REMOTE_ADDR'] = remote_addr
    end

    context 'with found job ID' do
      before do
        zc_basic_auth_login
      end

      it 'renders "Created" status' do
        post :create, params1
        expect(response.status).to eq(201)
      end

      it 'logs the notification' do
        allow(subject).to receive(:params).and_return(params1)
        msg = "Video job notification from #{remote_addr}:" \
              " job ID 1, state: finished"
        expect(Rails.logger).to receive(:info).with(msg)
        post :create, job: params1
      end

      it 'saves `meta` JSON with "job" from input' do
        post :create, params1
        record = Video.find(1)
        meta = JSON.parse(record.meta)
        expect(meta['job']['id']).to eq('1')
      end

      it 'saves `meta` JSON with "outputs" from input' do
        post :create, params1
        record = Video.find(1)
        meta = JSON.parse(record.meta)
        expect(meta['outputs']).to eq(outputs)
      end
    end

    context 'with not-found job ID' do
      before do
        allow(subject).to receive(:params).and_return(params99)
        zc_basic_auth_login
      end

      it 'logs the failed notification' do
        msg1 = "Video job notification from #{remote_addr}:" \
               " job ID 99, state: finished"
        msg2 = "Can not look up job ID 99"
        expect(Rails.logger).to receive(:info).with(msg1)
        expect(Rails.logger).to receive(:info).with(msg2)
        post :create, job: params99
      end

      it 'renders "Unprocessable Entity" when media record can not be found' do
        post :create, params99
        expect(response.status).to eq(422)
      end
    end

    # FIXME:
    # This needs to be moved to a spec for ZencoderAuthentication concern,
    # but I'm not sure where to put that.
    context 'with bad HTTP Basic Auth credentials' do
      before do
        zc_bad_basic_auth_login
      end
      it 'renders a 401 Unauthorized response' do
        post :create, params1
        expect(response.status).to eq(401)
      end
    end
  end  # #create_notifications

  describe '#transcoding_outputs' do
    let(:aws) { double }
    let(:config_option) { double }
    let(:outputs_settings) {
      [ config_option ]  # Array of Config::Option
    }
    before do
      allow(Settings).to receive(:aws).and_return(aws)
      allow(aws).to receive(:s3_destination_bucket)
                .and_return('bucket')
      allow(config_option).to receive(:extension)
                          .and_return('mp4')
      allow(config_option).to receive(:size)
                          .and_return(nil)
      allow(config_option).to receive(:h264_profile)
                          .and_return(nil)
      allow(config_option).to receive(:suffix)
                          .and_return(nil)
      allow(Settings).to receive_message_chain(:zencoder, :s3_credentials_name)
                     .and_return(false)
    end

    context 'with a file suffix' do
      before do
        allow(config_option).to receive(:suffix).and_return('-mobile')
      end
      it 'returns the correct array' do
        expect(subject.transcoding_outputs('name', outputs_settings))
          .to eq([{url: 's3://bucket/name-mobile.mp4'}])
      end
    end

    context 'without a file suffix' do
      it 'returns the correct array' do
        expect(subject.transcoding_outputs('name', outputs_settings))
          .to eq([{url: 's3://bucket/name.mp4'}])
      end
    end

    context 'with an H.264 profile parameter' do
      before do
        allow(config_option).to receive(:h264_profile).and_return('high')
      end
      it 'returns the correct array' do
        expect(subject.transcoding_outputs('name', outputs_settings))
          .to eq([{url: 's3://bucket/name.mp4', h264_profile: 'high'}])
      end
    end

    context 'with Zencoder named credentials' do
      before do
        allow(Settings).to receive_message_chain(:zencoder,
                                                 :s3_credentials_name)
                       .and_return('production')
      end
      it 'returns the correct array' do
        expect(subject.transcoding_outputs('name', outputs_settings))
          .to eq([{url: 's3://bucket/name.mp4', credentials: 'production'}])
      end
    end
  end
end
