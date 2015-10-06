
shared_examples 'redirecting controller' do |*actions|
  let(:resource_sym) { resource.class.name.downcase.to_sym }
  let(:parent_id_sym) { "#{parent.class.name.underscore}_id".to_sym }

  if actions.include? :create
    describe '#create' do
      before(:each) do
        parent
        resource.class.destroy(resource.class.find(resource.id)) if
          resource.class.where(id: resource.id).present?
      end

      it 'redirects to the new resource' do
        post :create, parent_id_sym => parent.id,
                      resource_sym => attributes
        expect(response).to redirect_to resource.class.last
      end

      context 'with invalid attributes' do
        it 're-renders :new view' do
          post :create, parent_id_sym => parent.id,
                        resource_sym => invalid_attributes
          expect(response).to render_template :new
        end
      end
    end
  end
end
