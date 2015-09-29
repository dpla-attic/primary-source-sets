namespace :primary_source_sets do
  namespace :samples do

    desc 'Create a sample admin account'
    task :create_admin => :environment do
      Admin.new({ email: 'sample@dp.la',
                  password: 'password',
                  password_confirmation: 'password' }).save
    end
  end
end
