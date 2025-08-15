source "https://rubygems.org"

ruby "3.2.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
# gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.6'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.3'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# common gems
gem 'pg', '~> 1.5', '>= 1.5.6'
gem 'devise', '~> 4.9', '>= 4.9.4'
gem 'haml', '~> 6.3'
gem 'haml-rails', '~> 2.1'
gem 'globalize', '~> 6.3'
gem 'globalize-accessors', '~> 0.3.0'
gem 'globalize-validations', '~> 1.0'
gem 'simple_form', '~> 5.3'
gem 'ancestry', '~> 4.3', '>= 4.3.3'
gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'browser', '~> 5.3', '>= 5.3.1'
gem 'nokogiri', '~> 1.16', '>= 1.16.4'
gem 'paranoia', '~> 2.6', '>= 2.6.3'
gem 'tailwindcss-rails', '~> 2.4'
gem 'meilisearch-rails', '~> 0.12.0'
gem 'requestjs-rails', '~> 0.0.11'
gem 'route_translator', '~> 14.1', '>= 14.1.1'
gem "chartkick"
gem "groupdate"
gem 'goldiloader', '~> 5.2', '>= 5.2.2'
gem 'pagy', '~> 9.0', '>= 9.0.6'
gem 'redis-rails'
gem 'rubyzip'
gem "roo", "~> 2.10.0"
gem 'rack-attack'
gem 'sanitize', '~> 6.0', '>= 6.0.2'


# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[ mri windows ]
  gem 'pry', '~> 0.14.2'
  gem 'solid_cache', '~> 0.7.0'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'mini_magick'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
