require 'rails_helper'

describe 'documents/new.html.erb', type: :view do
  before(:each) { assign(:document, build(:document_factory)) }
  it_behaves_like 'renderable new media view'
end
