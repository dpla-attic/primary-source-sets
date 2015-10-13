source 'https://rubygems.org'

gem 'rails', '~> 4.1.6'
gem 'sqlite3', '~> 1.3.8'
gem 'pg', '0.18.2'
gem 'uglifier', '~> 2.7.1'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer',  '~> 0.12.2', platforms: :ruby
gem 'sass-rails', '~> 4.0.3'
gem 'jquery-rails', '~> 3.1.3'
gem 'config', '~> 1.0.0'
gem 'redcarpet', '~> 3.3'
gem 'friendly_id', '~> 5.1.0'
gem 'devise', '3.4.1'
gem 'breadcrumbs_on_rails', '~> 2.3.0'
gem 'meta-tags', '~> 2.0.0'
gem 'httparty', '~> 0.11.0'
gem 'unicorn', '4.8.3'
gem 'rubocop', '~> 0.32.1', require: false
# s3_browser_uploads is pinned precisely because the last version, 0.1.2,
# came out in December, 2013, and I'm cautious about a change after this long
# a time being disruptive. --MB
gem 's3_browser_uploads', '0.1.2'
gem 'zencoder', '~>2.5'
gem 'navigasmic', '~>1.0'

group :test, :development do
  gem 'rspec-core', '~> 3.3.2'
  gem 'rspec-rails', '~> 3.3.3'
  gem 'factory_girl_rails', '~> 4.4.0'
  gem 'pry', '~> 0.10.1'
  gem 'pry-doc', '~> 0.8.0'
  gem 'pry-rails', '~> 0.3.4'
  gem 'awesome_print', '~> 1.2.0'
  gem 'codeclimate-test-reporter', '~> 0.4.7', require: false
  gem 'database_cleaner', '~> 1.3.0', require: false

  gem 'json-ld', '~>1.1.9'
end

group :development do
  gem 'zencoder-fetcher'
end

group :dpla_branding do
  gem 'dpla_frontend_assets', git: 'git@github.com:dpla/frontend-assets.git'
end
