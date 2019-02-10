# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.3"

gem "activeadmin"
gem "bcrypt"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", "~> 4.2.1"
gem "default_value_for", "~> 3.1"
gem "httparty"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "kaminari", "~> 1.0"
gem "pg", ">= 0.18", "< 2.0"
gem "pry-rails"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.2"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "validate_url", "~> 1.0"
gem "devise", "~> 4.6.0"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop", "~> 0.0"
end

group :development do
  gem "awesome_print"
  gem "better_errors"
  gem "bullet"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
