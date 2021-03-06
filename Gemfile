# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bcrypt', '~> 3.1.16'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bootstrap', '~> 5.0.1'
gem 'devise', '~> 4.2'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'faraday'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'octicons_helper'
gem 'octokit', '~> 4.0'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'
gem 'sass-rails', '>= 6'
gem 'sprockets-rails', '~> 3.0', '>= 3.0.4'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'letter_opener'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
