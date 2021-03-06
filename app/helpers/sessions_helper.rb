# frozen_string_literal: true

module SessionsHelper
  def store_return_to
    session[:return_to] = request.url
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue
    session[:user_id] = nil
    @current_user = nil
  end

  def logged_in?
    !!current_user
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
