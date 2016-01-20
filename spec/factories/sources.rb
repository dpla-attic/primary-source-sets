FactoryGirl.define do
  factory :source_factory, class: Source do
    name 'The birthday button'
    aggregation 'c3702b42c7e3daf5aafe47151184ba33'
    textual_content 'The birthday button is a beautiful artifact.'
    citation 'By Tove Jansson'
    credits 'Courtesy of Finland'
    featured false
    association :source_set, factory: :source_set_factory
  end

  factory :invalid_source_factory, class: Source do
    aggregation nil
  end

  factory :published_source_factory, class: Source do
    name 'The Quandary'
    aggregation 'c3702b42c7e3daf5aafe47151184ba33'
    textual_content 'Flummoxed by job, kvetching W. zaps Iraq.'
    citation 'As Seen on TV'
    credits 'By Thomas H. Ince'
    featured false
    association :source_set, factory: :published_source_set_factory
  end
end
