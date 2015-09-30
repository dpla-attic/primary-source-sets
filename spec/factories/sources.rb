FactoryGirl.define do
  factory :source_factory, class: Source do
    name 'The birthday button'
    aggregation 'c3702b42c7e3daf5aafe47151184ba33'
    textual_content 'The birthday button is a beautiful artifact.'
    citation 'By Tove Jansson'
    credits 'Courtesy of Finland'
    association :source_set, factory: :source_set_factory
  end

  factory :invalid_source_factory, class: Source do
    aggregation nil
  end
end
