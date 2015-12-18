
shared_examples 'a notification endpoint' do |model_class|

  # Include ZencoderAuthHelper for zc_basic_auth_login
  include ZencoderAuthHelper

  describe '#create_notification' do
    let(:remote_addr) { '192.168.0.2' }
    let(:outputs) { ['a'] }
    let(:model_instance) {
      create("#{model_class.to_s.downcase}_factory".to_sym)
    }
    let(:model_with_nil_meta) {
      create("#{model_class.to_s.downcase}_with_nil_meta_factory".to_sym)
    }
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

    before do
      allow(model_class).to receive(:find_by_transcoding_job)
                  .with('1')
                  .and_return(model_instance)
      allow(model_class).to receive(:find_by_transcoding_job)
                  .with('2')
                  .and_return(model_with_nil_meta)
      allow(model_class).to receive(:find_by_transcoding_job)
                  .with('99')
                  .and_return(nil)
      @request.env['REMOTE_ADDR'] = remote_addr
    end

    context 'with found job ID' do
      before do
        zc_basic_auth_login
        allow(subject).to receive(:render).and_return(nil)
      end

      it 'renders "Created" status' do
        allow(subject).to receive(:params).and_return(params1)
        expect(subject).to receive(:render)
                       .with({nothing: true, status: :created})
                       .and_return(nil)
        subject.create_notification(model_class)
      end

      it 'logs the notification' do
        allow(subject).to receive(:params).and_return(params1)
        msg = "#{model_class.to_s} job notification from #{remote_addr}:" \
              " job ID 1, state: finished"
        expect(Rails.logger).to receive(:info).with(msg)
        subject.create_notification(model_class)
      end

      it 'saves `meta` JSON with "job" from input' do
        allow(subject).to receive(:params).and_return(params1)
        subject.create_notification(model_class)
        record = model_class.find(1)
        meta = JSON.parse(record.meta)
        expect(meta['job']['id']).to eq('1')
      end

      it 'saves `meta` JSON with "outputs" from input' do
        allow(subject).to receive(:params).and_return(params1)
        subject.create_notification(model_class)
        record = model_class.find(1)
        meta = JSON.parse(record.meta)
        expect(meta['outputs']).to eq(outputs)
      end
    end

    context 'with not-found job ID' do
      before do
        allow(subject).to receive(:params).and_return(params99)
        allow(subject).to receive(:render).and_return(nil)
        zc_basic_auth_login
      end

      it 'logs the failed notification' do
        allow(subject).to receive(:params).and_return(params99)

        msg1 = "#{model_class.to_s} job notification from #{remote_addr}:" \
               " job ID 99, state: finished"
        msg2 = "Can not look up job ID 99"
        expect(Rails.logger).to receive(:info).with(msg1)
        expect(Rails.logger).to receive(:info).with(msg2)
        subject.create_notification(model_class)
      end

      it 'renders "Unprocessable Entity" when media record can not be found' do
        allow(subject).to receive(:params).and_return(params99)
        expect(subject).to receive(:render)
                       .with({nothing: true, status: :unprocessable_entity})
                       .and_return(nil)
        subject.create_notification(model_class)
      end
    end
  end  # #create_notification
end
