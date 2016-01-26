##
# This has basic controller specs for :index, :show, :create, :update, :destroy
#
# @param actions Symbol the actions for this examples to test.
#
# This assumes the following variable have been defined in the controller spec,
# or are passed as a block to this example:
#   :resource
#   :attributes (:create and update only)
#   :invalid_attributes (:create and :update only)
#
shared_examples 'basic controller' do |*actions|

  let(:resource_sym) { resource.class.name.underscore.to_sym }

  if actions.include? :index
    describe '#index' do

      it 'sets resources variable' do
        get :index
        expect(assigns(resource.class.name.pluralize.underscore.to_sym))
          .to include(resource)
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end

    end
  end

  if actions.include? :show
    describe '#show' do

      it 'sets resource variable' do
        get :show, id: resource.id
        expect(assigns(resource_sym)).to eq(resource)
      end

      it 'renders the :show view' do
        get :show, id: resource.id
        expect(response).to render_template :show
      end
    end
  end

  if actions.include? :create
    describe '#create' do
      it 'creates a new resource' do
        # Can not use expect ... .to change(...).by(1) below.
        # Might be related to using login_admin in some enclosing contexts.
        count = resource.class.count
        post :create, resource_sym => attributes
        expect(resource.class.count).to eq(count + 1)
      end

      context 'with invalid attributes' do
        it 'does not save new resource' do
          expect do
            post :create, resource_sym => invalid_attributes
          end.to change(resource.class, :count).by(0)
        end
      end
    end
  end

  if actions.include? :update
    describe '#update' do

      let(:field_sym) { attributes.keys.first }

      it 'updates the resource' do
        resource
        patch :update, id: resource.id,
                       resource_sym => { field_sym => 'new-field-value' }
        resource.reload
        expect(resource.send(field_sym)).to eq('new-field-value')
      end

      it 'redirects to the updated resource' do
        patch :update, id: resource.id,
                       resource_sym => { field_sym => 'new-field-value' }
        expect(response).to redirect_to resource
      end

      context 'with invalid attributes' do

        it 'does not update the resource' do
          expect do
            patch :update, id: resource.id,
                           resource_sym => invalid_attributes
            resource.reload
          end.not_to change(resource, invalid_attributes.keys.first)
        end

        it 're-renders :edit view' do
          patch :update, id: resource.id,
                         resource_sym => invalid_attributes
          expect(:response).to render_template :edit
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

      it 'redirects to :index' do
        resource
        delete :destroy, id: resource.id
        path = "#{resource.class.name.pluralize.underscore}_path"
        expect(response)
          .to redirect_to Rails.application.routes.url_helpers.send(path)
      end
    end
  end
end
