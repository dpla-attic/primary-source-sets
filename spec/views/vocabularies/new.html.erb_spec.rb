require 'rails_helper'

describe 'vocabularies/new.html.erb', type: :view do
  before { assign(:vocabulary, build(:vocabulary_factory)) }
  it_behaves_like 'renderable view'
end
