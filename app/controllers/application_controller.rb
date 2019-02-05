class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

	def redirect_to_login_if_needed
		redirect_to login_path unless current_user
	end
end
