require 'rails_helper'

describe 'documents/show.html.erb', type: :view do

  let(:document) { create(:document_factory) }

  before do
    assign(:document, document)
  end

  it_behaves_like 'renderable view'

  it 'renders the document' do
    render
    expect(rendered).to include(document.file_name)
  end
end
