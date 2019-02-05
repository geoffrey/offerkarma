class UsersController < ApplicationController
  def login
  end

  def post_login
  	user = User.find_or_create_by!(email: email_param)

  	if user.new_record?
  		redirect_to offers_path
  	else
  		redirect_to login_path
  	end
  end

  def signup
  end

	def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
    else
      render 'signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def email_param
  	params.require(:email, :password)
  end
end
