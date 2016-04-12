source 'https://rubygems.org'
ruby '2.1.2'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'bootstrap_form'
gem 'bcrypt', '~> 3.1.7'
gem 'fabrication'
gem 'faker'
gem 'sidekiq'
gem 'sinatra', require:false
gem 'slim'
gem "sentry-raven"

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '~> 3.0'
  gem 'letter_opener'
end



group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', '~> 3.0'
  
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'rack_session_access'
  gem 'launchy'
  gem 'capybara-email'
end

group :production do
  gem 'rails_12factor'
  gem 'unicorn'
end

