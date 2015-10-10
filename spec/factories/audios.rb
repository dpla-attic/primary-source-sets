FactoryGirl.define do
  factory :audio_factory, class: Audio do
    file_base 'adventures-of-moomin'
    meta '{"cloudfront_domain":"x", ' \
         '"output_settings":[{"extension":"mp3"},{"extension":"m4a"},' \
         '{"extension":"ogg"}]}'
  end

  factory :invalid_audio_factory, class: Audio do
    file_base nil
  end
end
