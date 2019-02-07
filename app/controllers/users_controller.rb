class UsersController < ApplicationController	
  def login
  end

  def post_login
  	user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      log_in user
      flash[:success] = "You are now logged in."
      redirect_to offers_path
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "login"
    end
  end

  def signup
  	@user = User.new
  end

	def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      p "setting flash"
      flash[:success] = "You are now logged in."
      redirect_to offers_path
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "signup"
    end
  end

  def logout
  	log_out
    flash[:warning] = "You have been logged out."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def email_param
  	params.require(:user).permit(:email, :password)
  end
end
