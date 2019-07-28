class SpeciesController < ApplicationController
  before_action :check_for_login

  def index
    @species = Species.all
  end

  def new
    @species = Species.new
  end

  def create
    @species = Species.create params_character
    @species.user_id = @current_user.id
    @current_user.characters << @species
    # @TODO change to character index path
    redirect_to species_path(@species)
  end

  def show
    @species = Species.find params[:id]
  end

  def edit
    # Only show this page, if the character is the @current_user's
    @species = Species.find params[:id]
    if @species.user_id == @current_user.id
      render :edit
    else
      redirect_to species_path
    end
  end

# TODO: how to cause error if dont fill in all required fields
  def update
    species = Species.find params[:id]
    species.update params_species
    redirect_to species
  end

  def destroy
    Species.destroy params[:id]
    redirect_to species_path
  end

  private
  def params_species
    params.require(:character).permit(:name, :age, :talent, :user_id, :species_id)
  end
end
