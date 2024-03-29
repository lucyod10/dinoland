class CharactersController < ApplicationController
  before_action :check_for_login

  def index
    @characters = Character.all
  end

  def new
    @coins = @current_user.coins
    @character = Character.new
    # Create a hash to link species id with their image, this is added in HTML to be used in main.js
    # TODO: make default image something else - "choose dino" or something.
    @species_images = {}
    @species = Species.all
    @species.each do |s|
      @default_image = s.image if @default_image.nil?
      @species_images[ s.id ] = s.image
    end

    # Create a hash to link accessory id with their image, this is added in HTML to be used in main.js
    @accessory_images = {}
    @accessories = Accessory.all
    @accessories.each do |a|
      @default_image = a.image if @default_image.nil?
      @accessory_images[ a.id ] = a.image
    end
  end

  def create
    # create the character
    @character = Character.create params_character
    @character.user_id = @current_user.id
    @current_user.characters << @character

    # find the checkboxes from params accessory[id][]
    # inside this will be an array of checked accessories.
    # for each of these, create a new Posession
    @posessions = params[:accessory][:id]
    @posessions.each do |p|
      if p.present?
        # TODO: find x and y values for each posession.
        # find the x and y coordinates saved
        @positions = params[:positions]
        @x_pos = 0
        @y_pos = 0

        @positions.each do |key, value|
          if key.include? p
            # they match, find the X and Y values.
            if key.include? "x"
              @x_pos = value
            elsif key.include? "y"
              @y_pos = value
            end
          end
        end

        new_posession = Posession.create :accessory_id => p, :character_id => @character.id, :x_pos => @x_pos, :y_pos => @y_pos
        @character.posessions << new_posession
      end

      # change users coins based on accessories selected.
      @coins = params[:userCoins]
      @current_user.coins = @coins
      @current_user.save
    end

    redirect_to character_path(@character)
  end

  def show
    @character = Character.find params[:id]
    @accessories = Accessory.all
  end

  def edit
    @character = Character.find params[:id]
    @coins = @current_user.coins
    # Create a hash to link species id with their image, this is added in HTML to be used in main.js
    @species_images = {}
    @species = Species.all
    @species.each do |s|
      @default_image = s.image if @default_image.nil?
      @species_images[ s.id ] = s.image
    end

    # Create a hash to link accessory id with their image, this is added in HTML to be used in main.js
    @accessory_images = {}
    @accessories = Accessory.all
    @accessories.each do |a|
      @default_image = a.image if @default_image.nil?
      @accessory_images[ a.id ] = a.image
    end

    # Only show this page, if the character is the @current_user's
    if @character.user_id == @current_user.id || @current_user.admin == true
      render :edit
    else
      redirect_to characters_path
    end
  end

# TODO: how to cause error if dont fill in all required fields
  def update
    character = Character.find params[:id]

    # Before creating a new posession, check if it exists already and if it does just update the X and Y values.

    # find the checkboxes from params accessory[id][]
    # inside this will be an array of checked accessories.
    # for each of these, create a new Posession
    @posessions = params[:accessory][:id]
    @posessions.each do |p|
      if p.present?
        @positions = params[:positions]
        @x_pos = 0
        @y_pos = 0

        @positions.each do |key, value|
          if key.include? p
            # they match, find the X and Y values.
            if key.include? "x"
              @x_pos = value
            elsif key.include? "y"
              @y_pos = value
            end
          end
        end

        # check if posession doesnt already exist.
        if character.posessions.exists?(accessory_id: p)
          # find the posession and remove it from the character
          oldposession = character.posessions.where(accessory_id: p)
          oldposession.each do |item|
            if @x_pos != "30" && @y_pos != "500"
              character.posessions.delete(item)
              # associate a new posession with the updated values.
              new_posession = Posession.create :accessory_id => p, :character_id => character.id, :x_pos => @x_pos, :y_pos => @y_pos
              character.posessions << new_posession
            end
          end
          # if the posession already existed, check if the values have been moved and if they havent then do not remove, nor create a new entry.
        else
          # associate a new posession with the updated values.
          new_posession = Posession.create :accessory_id => p, :character_id => character.id, :x_pos => @x_pos, :y_pos => @y_pos
          character.posessions << new_posession
        end


      end

      # change users coins based on accessories selected.
      @coins = params[:userCoins]
      @current_user.coins = @coins
      @current_user.save
    end

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
