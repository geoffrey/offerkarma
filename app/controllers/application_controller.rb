# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

  before_action :store_return_to

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def authenticate_admin_user!
    return true if Rails.env.development?

    authenticate_or_request_with_http_basic("admin") do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(username, ENV.fetch("ADMIN_USERNAME")) &
        ActiveSupport::SecurityUtils.secure_compare(password, ENV.fetch("ADMIN_PASSWORD"))
    end
  end

  def handle_record_not_found
    redirect_to root_path
  end

  def redirect_back
    redirect_to(session[:return_to] || offers_path)
  end

  def redirect_to_offers_if_logged_in
    redirect_to offers_path if logged_in?
  end

  def redirect_to_login_if_needed
    redirect_to login_path unless logged_in?
  end
end
