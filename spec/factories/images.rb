FactoryGirl.define do
  factory :image_factory, class: Image do
    file_base 'picture-of-little-my'
    mime_type 'image/jpeg'
    size 'thumbnail'
    height '150'
    width '150'
    alt_text 'picture of Little My'
    association :attachable, factory: :source_set_factory
  end

  factory :invalid_image_factory, class: Image do
    file_base nil
    mime_type nil
  end
end
