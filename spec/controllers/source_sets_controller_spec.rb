require 'rails_helper'

describe SourceSetsController, type: :controller do

  let(:resource) { create(:source_set_factory) }
  let(:published) { create(:source_set_factory, published: true) }
  let(:attributes) { attributes_for(:source_set_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_source_set_factory) }

  context 'with the user not logged-in' do
    describe '#show' do
      describe 'request for json format' do
        context 'with a published set' do
          it 'renders the show json partial' do
            get :show, id: published.id, format: :json
            expect(response).to render_template(partial: '_show.json.erb')
          end
        end
      end
    end
  end
end
