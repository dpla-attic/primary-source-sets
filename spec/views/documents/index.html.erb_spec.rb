require 'rails_helper'

describe 'documents/index.html.erb', type: :view do

  before do
    assign(:documents, [create(:document_factory, file_name: 'file1'),
                        create(:document_factory, file_name: 'file2')])
  end

  it 'renders each document' do
    render
    expect(rendered).to include('file1')
    expect(rendered).to include('file2')
  end
end
