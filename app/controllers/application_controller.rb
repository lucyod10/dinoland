class ApplicationController < ActionController::Base
  before_action :fetch_user # this means before you do anything, run fetch_user

  private
  # set up an @current_user instance variable if we can find a user_id in this session.
  def fetch_user
      @current_user = User.find_by :id => session[:user_id] if session[:user_id].present?
      session[:user_id] = nil unless @current_user.present?
    end

    def check_for_login
      if @current_user.present? && @current_user.admin == true
        # If you're logged in and an admin, go forth
      elsif @current_user.present? && @current_user.admin == false
        # If you're logged in and not an admin
      else
        # If you're logged out
        redirect_to login_path
      end
    end

    def logged_in_send_home
      if @current_user.present? && @current_user.admin == true
        # If you're logged in and an admin, go forth
      elsif @current_user.present? && @current_user.admin == false
        # If you're logged in and not an admin
        redirect_to root_path
      else
        # If you're logged out
      end
    end

end
