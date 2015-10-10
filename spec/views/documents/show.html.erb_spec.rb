require 'rails_helper'

describe 'documents/show.html.erb', type: :view do

  let(:document) { create(:document_factory) }

  before do
    assign(:document, document)
  end

  # FIXME:  view relies on @base_src variable set in controller
  xit 'renders the document' do
    render
    expect(rendered).to include(document.file_name)
  end
end
