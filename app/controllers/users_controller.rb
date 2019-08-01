class UsersController < ApplicationController
  before_action :check_for_login, :only => [:edit, :update]
  before_action :logged_in_send_home, :only => [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if params[:file].present?
      # Then call Cloudinary's upload method, passing in the file in params
      req = Cloudinary::Uploader.upload(params[:file])
      # Using the public_id allows us to use Cloudinary's powerful image
      # transformation methods.
      @user.profile_image = req["public_id"]
      @user.save
    end


    if @user.save
          session[:user_id] = @user.id
          redirect_to root_path
        else
          render :new # do this instead of redirect, so that the form doesnt clear.
        end
  end

  def edit
    if @current_user.admin == true
      @user = User.find params[:id]
    else
      @user = @current_user
    end
  end

  def show
    @user = User.find params[:id]
  end

  def update
    if @current_user.admin == true
      user = User.find params[:id]
    else
      user = @current_user
      # TODO: how to make the coins only pass through if user is an admin.
      params[:coins] = user.coins
    end

    if params[:file].present?
      # Then call Cloudinary's upload method, passing in the file in params
      req = Cloudinary::Uploader.upload(params[:file])
      # Using the public_id allows us to use Cloudinary's powerful image
      # transformation methods.
      user.profile_image = req["public_id"]
      user.save
    end
    user.update user_params
    redirect_to user_path
  end

  def destroy
    user = User.find params[:id]
    if @current_user.admin == true || @current_user.id == user.id
      User.destroy params[:id]
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :coins, :profile_image)
  end
end
