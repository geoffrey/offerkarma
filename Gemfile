# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.3"

gem "activeadmin"
gem "bcrypt"
gem "bootsnap", ">= 1.1.0", require: false
gem "default_value_for", "~> 3.1"
gem "httparty"
gem "impressionist"
gem "kaminari", "~> 1.0"
gem "monetize"
gem "money"
gem "newrelic_rpm"
gem "pg", ">= 0.18", "< 2.0"
gem "pry-rails"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.2"
gem "recaptcha"
gem "sass-rails", "~> 5.0"
gem "sidekiq", "~> 5.2.5"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "validate_url", "~> 1.0"
gem "webpacker", "~> 3.0"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails", "~> 2.6"
  gem "rubocop", "~> 0.0"
end

group :development do
  gem "awesome_print"
  gem "better_errors"
  gem "bullet"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "mailcatcher"
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
