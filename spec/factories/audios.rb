FactoryGirl.define do
  factory :audio_factory, class: Audio do
    file_base 'adventures-of-moomin'
  end

  factory :invalid_audio_factory, class: Audio do
    file_base nil
  end
end
