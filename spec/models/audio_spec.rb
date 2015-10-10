require 'rails_helper'

describe Audio, type: :model do
  let(:attributes) { attributes_for(:audio_factory) }
  it_behaves_like 'media asset'
end
