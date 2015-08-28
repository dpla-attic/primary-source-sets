FactoryGirl.define do
  factory :source_set_factory, class: SourceSet do
    name 'Moominvalley'
    description 'This set uses primary sources to explore Moominvalley.'
    overview 'Moominvalley and its inhabitants are lovely.'
    resources 'Here are some additional resources about Moominvalley.'
    published false
  end

  factory :invalid_source_set_factory, class: SourceSet do
    name nil
  end
end
