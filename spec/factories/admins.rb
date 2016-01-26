FactoryGirl.define do
  factory :admin, class: Admin do
    email 'test@example.org'
    password 'password'
    confirmed_at DateTime.now
    confirmation_sent_at DateTime.now
  end

  factory :existing_admin_factory, class: Admin do
    email 'test2@example.org'
    encrypted_password '$2a$04$1Za0y3arNrlTBH7geX2qXeTQAqFGOkKK9VWh/K9LmT1eG3ZWB/rfC'
    confirmed_at DateTime.now
    confirmation_sent_at DateTime.now
  end

  factory :brandnew_admin_factory, class: Admin do
    skip_create
    email 'test3@example.org'
  end

  factory :unconfirmed_admin_factory, class: Admin do
    email 'test4@example.org'
  end

  factory :invalid_admin_factory, class: Admin do
    email 'x'
  end
end
