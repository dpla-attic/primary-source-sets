FactoryGirl.define do
  factory :admin_factory, class: Admin do
    email 'test1@example.org'
    encrypted_password '$2a$04$1Za0y3arNrlTBH7geX2qXeTQAqFGOkKK9VWh/K9LmT1eG3ZWB/rfC'
    confirmed_at DateTime.now
    confirmation_sent_at DateTime.now
    status 2
    username 'Admin user'
  end

  factory :brandnew_admin_factory, class: Admin do
    skip_create
    email 'test2@example.org'
    status 0
  end

  factory :unconfirmed_admin_factory, class: Admin do
    email 'test3@example.org'
    status 0
    username 'User Name'
  end

  factory :reviewer_admin_factory, class: Admin do
    email 'test4@example.org'
    encrypted_password '$2a$04$1Za0y3arNrlTBH7geX2qXeTQAqFGOkKK9VWh/K9LmT1eG3ZWB/rfC'
    confirmed_at DateTime.now
    confirmation_sent_at DateTime.now
    status 0
  end

  factory :editor_admin_factory, class: Admin do
    email 'test5@example.org'
    encrypted_password '$2a$04$1Za0y3arNrlTBH7geX2qXeTQAqFGOkKK9VWh/K9LmT1eG3ZWB/rfC'
    confirmed_at DateTime.now
    confirmation_sent_at DateTime.now
    status 1
  end

  factory :invalid_admin_factory, class: Admin do
    email 'x'
  end
end
