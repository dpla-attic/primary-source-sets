FactoryGirl.define do
  factory :tag_factory, class: Tag do
    label 'Revolution and the New Nation (1754-1820s)'
    uri 'http://www.nchs.ucla.edu/history-standards/us-history-content-standards'
  end

  factory :invalid_tag_factory, class: Tag do
    label nil
  end
end
