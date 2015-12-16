
# `resource` will be the @audio or @video in the controller.
# `type` is 'audio' or 'video', the 2nd argument to #create_media.
shared_examples 'an encoder' do |type|

  describe '#create_media' do

    let(:default_params) do
      {
        type => {
          key: 'the_s3_key'
        }
      }
    end

    before do
      allow(subject).to receive(:params)
                    .and_return(default_params)
      allow(resource).to receive(:capitalize)
                     .and_return(type.capitalize)
    end

    context 'when job creation is successful' do
      before do
        allow(subject).to receive(:create_transcoding_job)
                      .and_return('the_id')
      end

      it 'saves the model' do
        expect(resource).to receive(:save).and_return(true)
        allow(subject).to receive(:render).and_return(nil)
        subject.create_media(resource, type)
      end

      it 'renders successful response' do
        success_render = {
          json: {
            id: resource.id,
            resource: subject.send("#{type}_path", resource)
          },
          status: :created
        }
        allow(resource).to receive(:save).and_return(true)
        expect(subject).to receive(:render).with(success_render)
        subject.create_media(resource, type)
      end

      context 'but when the model can not be saved' do
        it 'renders HTTP 500 Internal Server Error' do
          failure_render = {
            json: {
              message: "Could not save #{resource.capitalize} record"
            },
            status: :internal_server_error
          }
          allow(resource).to receive(:save).and_return(false)
          expect(subject).to receive(:render).with(failure_render)
          subject.create_media(resource, type)
        end
      end
    end

    context 'when job creation fails' do
      before do
        allow(subject).to receive(:create_transcoding_job)
                      .and_raise(RuntimeError.new("Fooey"))
      end

      it 'renders HTTP 500 Internal Server Error' do
        failure_render = {
          json: {
            message: "Could not create #{resource.capitalize} transcoding " \
                     "job: Fooey"
          },
          status: :internal_server_error
        }
        expect(subject).to receive(:render).with(failure_render)
        subject.create_media(resource, type)
      end
    end
  end  # #create_media


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
          subject.send(:create_transcoding_job, 'a', 'b', {})
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
          subject.send(:create_transcoding_job, 'a', 'b', {})
        end
      end
    end

    it 'logs the job creation' do
      allow(response).to receive(:code).and_return('201')
      msg = "Creating job with: {:input=>\"s3://" \
            "#{Settings.aws.s3_upload_bucket}/a\", :outputs=>[], " \
            ":notifications=>[\"http://zencoderfetcher/\"]}"
      expect(Rails.logger).to receive(:info).with(msg)
      subject.send(:create_transcoding_job, 'a', 'b', {})
    end

    it 'returns a String job ID' do
      allow(response).to receive(:code).and_return('201')
      expect(subject.send(:create_transcoding_job, 'a', 'b', {}))
        .to eq('123')
    end
  end  # #create_transcoding_job


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
        expect(subject.send(:transcoding_outputs, 'name', outputs_settings))
          .to eq([{url: 's3://bucket/name-mobile.mp4'}])
      end
    end

    context 'without a file suffix' do
      it 'returns the correct array' do
        expect(subject.send(:transcoding_outputs, 'name', outputs_settings))
          .to eq([{url: 's3://bucket/name.mp4'}])
      end
    end

    context 'with an H.264 profile parameter' do
      before do
        allow(config_option).to receive(:h264_profile).and_return('high')
      end
      it 'returns the correct array' do
        expect(subject.send(:transcoding_outputs, 'name', outputs_settings))
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
        expect(subject.send(:transcoding_outputs, 'name', outputs_settings))
          .to eq([{url: 's3://bucket/name.mp4', credentials: 'production'}])
      end
    end
  end  # #transcoding_outputs

  describe '#transcoding_notifications' do
    let(:n_url) { 'http://user:pass@host/notification_path' }
    before do
      allow(subject).to receive(:notifications_url)
                    .and_return(n_url)
    end

    context 'in production with RAILS_ENV' do
      before do
        allow(Rails).to receive_message_chain(:env, :production?)
                    .and_return(true)
      end

      it 'returns url for notifications endpoint' do
        expect(subject.send(:transcoding_notifications)).to eq([n_url])
      end
    end

    context 'in production with dev_real_zc_notification' do
      before do
        allow(Rails).to receive_message_chain(:env, :production?)
                    .and_return(false)
        allow(Settings).to receive(:dev_real_zc_notification)
                    .and_return(true)
      end

      it 'returns URL for notifications endpoint' do
        expect(subject.send(:transcoding_notifications)).to eq([n_url])
      end
    end

    context 'in development' do
      before do
        allow(Rails).to receive_message_chain(:env, :production?)
                    .and_return(false)
      end

      it 'returns URL for Zencoder development' do
        expect(subject.send(:transcoding_notifications))
          .to eq(['http://zencoderfetcher/'])
      end
    end
  end
end
