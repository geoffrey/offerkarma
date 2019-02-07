class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

	def redirect_if_logged_in
		redirect_to offers_path if logged_in?
	end

	def redirect_to_login_if_needed
		redirect_to login_path unless logged_in?
	end
end
