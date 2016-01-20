
##
# Examples for methods that should redirect to the login page if requested
# by a user that it unauthenticated.
#
shared_examples 'anonymous user redirector' do |*actions|

  let(:resource_sym) { resource.class.name.underscore.to_sym }
  let(:signin_url) { "#{Settings.relative_url_root}#{new_admin_session_path}" }

  if actions.include? :create
    describe '#create' do
      it 'redirects to the sign-in page' do
        if defined?(parent_model)
          parent_id_sym = "#{parent_model.class.name.underscore}_id".to_sym
          post :create, parent_id_sym => parent_model.id,
                        resource_sym => attributes
        else
          post :create, resource_sym => attributes
        end
        expect(response).to redirect_to signin_url
      end
    end
  end

  if actions.include? :update
    describe '#update' do
      it 'redirects to the sign-in page' do
        patch :update, id: resource.id, foo: 'bar'
        expect(response).to redirect_to signin_url
      end
    end
  end

  if actions.include? :destroy
    describe '#destroy' do
      it 'redirects to the sign-in page' do
        delete :destroy, id: resource.id
        expect(response).to redirect_to signin_url
      end
    end
  end
end
