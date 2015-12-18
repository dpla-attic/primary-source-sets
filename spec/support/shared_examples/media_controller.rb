##
# This has media controller specs for :new, :create
#
# @param actions Symbol the actions for this example to test.
#
# This assumes the following variable have been defined in the controller spec,
# or are passed as a block to this example:
#   :resource
#   :attributes (:create only)
#
shared_examples 'media controller' do |*actions|

  let(:resource_sym) { resource.class.name.downcase.to_sym }
  let(:source) { create(:source_factory) }

  if actions.include? :create
    describe '#create' do
      it 'creates a new resource' do
        allow(subject).to receive(:create_transcoding_job)
                      .and_return('the_id')
        expect do
          post :create, resource_sym => attributes
        end.to change(resource.class, :count).by(1)
      end

      context 'with source' do
        it 'creates a new Attachment association' do
          attributes[:source_ids] = source.id
          allow(subject).to receive(:create_transcoding_job)
                        .and_return('the_id')

          expect do
            post :create, resource_sym => attributes
          end.to change(Attachment, :count).by(1)
        end
      end
    end
  end

  if actions.include? :new
    describe '#new' do
      context 'with source' do
        it 'sets @source variable from param' do
           get :new, source_id: source.id
           expect(assigns(:source)).to eq source
        end
      end
    end
  end
end
