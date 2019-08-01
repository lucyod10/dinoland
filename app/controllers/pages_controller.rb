class PagesController < ApplicationController
  before_action :check_for_login

  def home
    @characters = @current_user.characters
  end

  def play
    session[:selectedCharacter] = params[:selectedCharacterHidden]
    redirect_to game_path
  end

  def game
    # Logic to translate id of "feature_105" to "105"
    character_id = session[:selectedCharacter]
    character_id = character_id.scan(/\d/).join
    @character = Character.find character_id
    @coins = @current_user.coins
  end

  def add_coins
    if @current_user.coins.nil?
      @current_user.coins = 50
    else
      @current_user.coins += 50
    end
    @current_user.save
    redirect_to :game
  end
end
