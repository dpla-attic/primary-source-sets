require 'rails_helper'

describe 'documents/show.html.erb', type: :view do

  let(:document) { create(:document_factory) }

  before do
    assign(:document, document)
  end

  it 'renders the document' do
    render
    expect(rendered).to include(document.file_base)
  end
end
