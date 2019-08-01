class AccessoriesController < ApplicationController
  before_action :check_for_login

  def index
    @accessories = Accessory.all
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.create params_accessory
    @accessory.user_id = @current_user.id

    if params[:file].present?
      # Then call Cloudinary's upload method, passing in the file in params
      req = Cloudinary::Uploader.upload(params[:file])
      # Using the public_id allows us to use Cloudinary's powerful image
      # transformation methods.
      @accessory.image = req["public_id"]
      @accessory.save
    end


    @current_user.accessories << @accessory
    # @TODO change to accessory index path
    redirect_to accessory_path(@accessory)
  end

  def show
    @accessory = Accessory.find params[:id]

  end

  def edit
    # Only show this page, if the accessory is the @current_user's
    @accessory = Accessory.find params[:id]
    if @accessory.user_id == @current_user.id || @current_user.admin == true
      render :edit
    else
      redirect_to accessories_path
    end
  end

# TODO: how to cause error if dont fill in all required fields
  def update
    accessory = Accessory.find params[:id]

    if params[:file].present?
      # Then call Cloudinary's upload method, passing in the file in params
      req = Cloudinary::Uploader.upload(params[:file])
      # Using the public_id allows us to use Cloudinary's powerful image
      # transformation methods.
      accessory.image = req["public_id"]
      accessory.save
    end

    accessory.update params_accessory
    redirect_to accessory
  end

  def destroy
    Accessory.destroy params[:id]
    redirect_to accessories_path
  end

  private
  def params_accessory
    params.require(:accessory).permit(:name, :image, :cost, :user_id)
  end
end
