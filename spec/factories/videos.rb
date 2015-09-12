FactoryGirl.define do
  factory :video_factory, class: Video do
    file_base 'adventures-of-moomin'
    mime_type 'video/mp4'
    association :source, factory: :source_factory
  end

  factory :invalid_video_factory, class: Video do
    file_base nil
  end
end
