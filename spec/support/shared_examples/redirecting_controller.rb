##
# This has specs for controllers whose routes redirect after specified actions.
# Available actions to test are :create
#
# @param actions Symbol the actions for this examples to test.
#
# This assumes the following variable have been defined in the controller spec,
# or are passed as a block to this example:
#   :resource
#   :parent_model (optional for nested controllers)
#   :attributes
#   :invalid_attributes
#
shared_examples 'redirecting controller' do |*actions|
  let(:resource_sym) { resource.class.name.underscore.to_sym }

  let(:params) do
    params = { resource_sym => attributes }
    params["#{parent_model.class.name.underscore}_id".to_sym] =
      parent_model.id if defined?(parent_model)
    params
  end

  if actions.include? :create

    describe '#create' do
      before(:each) do
        resource.class.destroy(resource.class.find(resource.id)) if
          resource.class.where(id: resource.id).present?
      end

      it 'redirects to the new resource' do
        post :create, params
        expect(response).to redirect_to resource.class.last
      end

      context 'with invalid attributes' do
        it 're-renders :new view' do
          params[resource_sym] = invalid_attributes
          post :create, params
          expect(response).to render_template :new
        end
      end
    end
  end
end
