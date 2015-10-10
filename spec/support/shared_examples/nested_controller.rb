##
# This has specs for controllers whose routes are nested under a parent route.
# Available actions to test are :index, :create, :destroy
#
# @param actions Symbol the actions for this examples to test.
#
# This assumes the following variable have been defined in the controller spec,
# or are passed as a block to this example:
#   :resource
#   :parent
#   :attributes (:create only)
#   :invalid_attributes (:create only)
#
shared_examples 'nested controller' do |*actions|

  let(:resource_sym) { resource.class.name.downcase.to_sym }
  let(:parent_id_sym) { "#{parent.class.name.underscore}_id".to_sym }

  if actions.include? :index
    describe '#index' do

      it 'redirects to parent' do
        get :index, parent_id_sym => parent.id
        expect(response).to redirect_to parent
      end
    end
  end

  if actions.include? :create
    describe '#create' do

      before(:each) do
        parent
        resource.class.destroy(resource.class.find(resource.id)) if
          resource.class.where(id: resource.id).present?
      end

      it 'creates a new resource' do
        expect do
          post :create, parent_id_sym => parent.id,
                        resource_sym => attributes
        end.to change(resource.class, :count).by(1)
      end

      context 'with invalid attributes' do

        it 'does not save new resource' do
          expect do
            post :create, parent_id_sym => parent.id,
                          resource_sym => invalid_attributes
          end.to change(resource.class, :count).by(0)
        end
      end
    end
  end

  if actions.include? :destroy
    describe '#destroy' do

      it 'deletes the resource' do
        resource
        expect do
          delete :destroy, id: resource.id
        end.to change(resource.class, :count).by(-1)
      end

      it 'redirects to parent' do
        resource
        delete :destroy, id: resource.id
        expect(response).to redirect_to parent
      end
    end
  end
end
