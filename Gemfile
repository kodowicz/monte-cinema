source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'devise'
gem 'devise-jwt'
gem 'pundit', '~> 2.1'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rubocop', require: false 

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop', require: false
  gem 'bundle-audit', '~> 0.1.0'
  gem 'faker', '~> 2.18'

  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
end

group :development do
  gem 'bullet', '~> 6.1', '>= 6.1.4'
  gem 'brakeman', '~> 5.0', '>= 5.0.4'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'sentry-ruby'
gem 'sentry-rails'

gem 'sidekiq', '~> 6.2'
gem 'sidekiq-cron', '~> 1.2'

gem 'pagy', '~> 3.5'