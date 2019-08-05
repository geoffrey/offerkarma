# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "activeadmin"
gem "bcrypt"
gem "bootsnap", require: false
gem "coffee-script"
gem "default_value_for"
gem "httparty"
gem "kaminari"
gem "monetize"
gem "money"
gem "newrelic_rpm"
gem "pg", ">= 0.18", "< 2.0"
gem "pry-rails"
gem "puma"
gem "rails"
gem "recaptcha"
gem "sass-rails"
gem "sidekiq"
gem "turbolinks"
gem "twitter"
gem "uglifier"
gem "validate_url"
gem "webpacker"

group :development, :test do
  gem "dotenv-rails"
  gem "byebug"
  gem "rubocop"
end

group :development do
  gem "awesome_print"
  gem "better_errors"
  gem "bullet"
  gem "listen"
  gem "mailcatcher"
  gem "spring"
  gem "spring-watcher-listen"
  gem "web-console"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
