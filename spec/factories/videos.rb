FactoryGirl.define do
  factory :video_factory, class: Video do
    id 1
    file_base 'adventures-of-moomin'
    meta '{"cloudfront_domain":"a", "output_settings":[{"extension":"b"}]}'
    transcoding_job '1'
  end

  factory :video_with_nil_meta_factory, class: Video do
    id 2
    file_base 'f'
    meta nil
    transcoding_job '2'
  end

  factory :invalid_video_factory, class: Video do
    id 3
    file_base nil
  end
end
