class SpeciesController < ApplicationController
  before_action :check_for_login

  def index
    @species = Species.all
  end

  def new
    @species = Species.new
  end

  def create
    @species = Species.create params_species
    @species.user_id = @current_user.id

    if params[:file].present?
      # Then call Cloudinary's upload method, passing in the file in params
      req = Cloudinary::Uploader.upload(params[:file])
      # Using the public_id allows us to use Cloudinary's powerful image
      # transformation methods.
      @species.image = req["public_id"]
      @species.save
    end

    @current_user.species << @species

    # @TODO change to character index path
    redirect_to species_path(@species)
  end

  def show
    @species = Species.find params[:id]
    # Logic for number of characters using this species
    @num_characters = Character.includes(:species).where('species_id' => @species.id)

  end

  def edit
    # Only show this page, if the character is the @current_user's
    @species = Species.find params[:id]
    if @species.user_id == @current_user.id || @current_user.admin == true
      render :edit
    else
      redirect_to species_path
    end
  end

  def update
    species = Species.find params[:id]

    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      species.image = req["public_id"]
    end

    species.update params_species
    species.save
    redirect_to species
  end

  def destroy
    Species.destroy params[:id]
    redirect_to species_path
  end

  private
  def params_species
    params.require(:species).permit(:genus, :order, :diet, :image, :fun_fact, :user_id)
  end
end
