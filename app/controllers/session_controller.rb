class SessionController < ApplicationController
  before_action :check_for_login, :except => [:new, :create]
  def new
  end

  def create
    # find the user by their email address
    user = User.find_by :email => params[:email]
    # if the encrypted password matches the encrypted password in the database:
      # reditect to the root path
    # else
      # show them the login form again
    if user.present? && user.authenticate(params[:password])
      # session is a magical thing that remembers the things you give it
      # that way, you stay logged in :D
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error_message] = "Invalid email or password" # will only show once, and then disappear
      redirect_to login_path # for security reasons, you dont want to give them the error messages
    end
  end

  def characters
    @characters = @current_user.characters.all
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
