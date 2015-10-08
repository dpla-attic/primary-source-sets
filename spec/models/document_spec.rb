require 'rails_helper'

describe Document, type: :model do
  let(:attributes) { attributes_for(:document_factory) }
  it_behaves_like 'media asset'
end
