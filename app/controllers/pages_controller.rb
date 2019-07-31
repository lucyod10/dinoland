class PagesController < ApplicationController
  def home
    @characters = @current_user.characters
  end
end
