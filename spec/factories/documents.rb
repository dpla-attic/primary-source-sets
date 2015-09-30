FactoryGirl.define do
  factory :document_factory, class: Document do
    file_base 'adventures-of-moomin'
    mime_type 'application/pdf'
    association :source, factory: :source_factory
  end

  factory :invalid_document_factory, class: Document do
    file_base nil
  end
end
