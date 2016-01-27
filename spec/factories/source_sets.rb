FactoryGirl.define do
  factory :source_set_factory, class: SourceSet do
    name 'Moominvalley'
    description 'This set uses primary sources to explore Moominvalley.'
    overview 'Moominvalley and its inhabitants are lovely.'
    resources 'Here are some additional resources about Moominvalley.'
    year 1984
    published false
  end

  factory :published_source_set_factory, class: SourceSet do
    name "A Wizard's Job"
    description 'This set explores the use of panagrams in 21st-Century America'
    overview "A wizard's job is to vex chumps quickly in fog."
    resources 'Here are some additional resources for your consideration.'
    year 2016
    published true
  end

  factory :invalid_source_set_factory, class: SourceSet do
    name nil
  end
end
