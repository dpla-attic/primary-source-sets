FactoryGirl.define do
  factory :author_factory, class: Author do
    name 'Moominmamma'
    affiliation 'Moominvalley Public School'
  end

  factory :invalid_author_factory, class: Author do
    name nil
  end
end
