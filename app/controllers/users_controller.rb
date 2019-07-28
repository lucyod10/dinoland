class UsersController < ApplicationController
  before_action :check_for_login, :only => [:edit, :update]
  before_action :logged_in_send_home, :only => [:new, :create]
  # before_action :check_for_admin, :only => [:index]

  def index
    @users =  User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
          session[:user_id] = @user.id
          redirect_to root_path
        else
          render :new # do this instead of redirect, so that the form doesnt clear.
        end
  end

  def edit
    @user = @current_user
  end

  def update
    @current_user.update user_params
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :coins)
  end
end
