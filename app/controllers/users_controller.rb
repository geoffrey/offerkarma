# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :store_return_to, except: %i[account]
  before_action :redirect_to_login_if_needed, only: %i[account]
  before_action :redirect_to_offers_if_logged_in, only: %i[login post_login signup create]

  def account
    @offers = current_user.offers
  end

  def login; end

  def post_login
    user = User.find_by(email: params[:user][:email].downcase)
    verify_recaptcha!(model: user, env: Rails.env)
    if user&.authenticate(params[:user][:password])
      log_in user
      redirect_back
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "login"
    end
  end

  def signup
    @user = User.new
  end

  def create
    user_attr = user_params
    user_attr[:password_confirmation] = user_attr[:password]
    @user = User.new(user_attr)
    verify_recaptcha!(model: @user, env: Rails.env)
    Services.user_registration.sign_up(user: @user)
    log_in @user
    redirect_back
  rescue Users::Registration::UserCreationError
    flash.now[:danger] = "Invalid email/password combination"
    render "signup"
  end

  def logout
    log_out
    redirect_to root_path
  end

  def verify
    @user = User.find_by_email(params[:email])
    if @user &&
      !@user.verified? &&
      @user.authenticated?(:verification, params[:token])
      @user.verify!
      log_in @user
    else
      render 'verify_failed'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def email_param
    params.require(:user).permit(:email, :password)
  end
end
