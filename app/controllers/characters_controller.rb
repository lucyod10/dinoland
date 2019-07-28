class CharactersController < ApplicationController
  before_action :check_for_login

  def index
    @characters = Character.all
  end

  def new
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
