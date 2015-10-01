require 'rails_helper'

describe Video, type: :model do
  let(:attributes) { attributes_for(:video_factory) }
  it_behaves_like 'media asset'
end
