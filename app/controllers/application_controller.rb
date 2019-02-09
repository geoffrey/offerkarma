# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_admin_user!
    authenticate_or_request_with_http_basic("admin") do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(username, ENV.fetch["ADMIN_USERNAME"]) &
        ActiveSupport::SecurityUtils.secure_compare(password, ENV.fetch["ADMIN_PASSWORD"])
    end
  end

  def redirect_if_logged_in
    redirect_to offers_path if logged_in?
  end

  def redirect_to_login_if_needed
    redirect_to login_path unless logged_in?
  end
end
