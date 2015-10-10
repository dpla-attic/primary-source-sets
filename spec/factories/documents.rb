FactoryGirl.define do
  factory :document_factory, class: Document do
    file_name 'adventures-of-moomin'
  end

  factory :invalid_document_factory, class: Document do
    file_name nil
  end
end
