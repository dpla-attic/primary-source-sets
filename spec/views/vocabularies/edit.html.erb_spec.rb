require 'rails_helper'

describe 'vocabularies/edit.html.erb', type: :view do
  before { assign(:vocabulary, create(:vocabulary_factory)) }
  it_behaves_like 'renderable view'
end
