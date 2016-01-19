FactoryGirl.define do
  factory :vocabulary_factory, class: Vocabulary do
    name 'NHS time periods'
    filter true
  end

  factory :invalid_vocabulary_factory, class: Vocabulary do
    name nil
  end
end
