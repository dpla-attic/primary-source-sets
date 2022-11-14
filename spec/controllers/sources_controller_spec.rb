require 'rails_helper'

describe SourcesController, type: :controller do

  let(:resource) { create(:source_factory) }
  let(:published_source) { create(:published_source_factory) }
  let(:attributes) { attributes_for(:source_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_source_factory) }
  let(:parent_model) { resource.source_set }

  context 'with the user not logged-in' do

      describe 'request for json format' do
        context 'with a source belonging to a published set' do
          it 'renders the show json partial' do
            get :show, id: published_source.id, format: :json
            expect(response).to render_template(partial: '_show.json.erb')
          end
        end
      end
    end
  end
end
