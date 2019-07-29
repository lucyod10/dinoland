class CharactersController < ApplicationController
  # TODO: edit the accessories for a character.
  # TODO: column for the X and Y position of the accessory per character. Perhaps stored in the many to many table?

  before_action :check_for_login

  def index
    @characters = Character.all
  end

  def new
    # Create a hash to link species id with their image
    # TODO: make default image something else - "choose dino" or something.
    @species_images = {}
    @species = Species.all
    @species.each do |s|
      @default_image = s.image if @default_image.nil?
      @species_images[ s.id ] = s.image
    end

    # Create list of all accessories to choose from.
    @accessory_images = {}
    @accessories = Accessory.all
    @accessories.each do |a|
      @default_image = a.image if @default_image.nil?
      @accessory_images[ a.id ] = a.image
    end

    @character = Character.new
  end

  def create
    @character = Character.create params_character
    @character.user_id = @current_user.id
    @current_user.characters << @character
    # @TODO change to character index path
    redirect_to character_path(@character)
  end

  def show
    @character = Character.find params[:id]
  end

  def edit
    # Only show this page, if the character is the @current_user's
    @character = Character.find params[:id]
    if @character.user_id == @current_user.id || @current_user.admin == true
      render :edit
    else
      redirect_to characters_path
    end
  end

# TODO: how to cause error if dont fill in all required fields
  def update
    character = Character.find params[:id]
    character.update params_character
    redirect_to character
  end

  def destroy
    Character.destroy params[:id]
    redirect_to characters_path
  end

  private
  def params_character
    params.require(:character).permit(:name, :age, :talent, :user_id, :species_id)
  end
end
