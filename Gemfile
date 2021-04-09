# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'amazing_print', '~> 1.3'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  gem 'rubocop-rails', '~> 2.9', '>= 2.9.1'
end

group :development do
  gem 'annotate', '~> 3.1', '>= 3.1.1'
  gem 'bullet', '~> 6.1', '>= 6.1.4'
  gem 'guard-livereload', '~> 2.5', '>= 2.5.2', require: false
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3', require: false
  gem 'listen', '~> 3.3'
  gem 'rack-livereload', '~> 0.3.17'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
