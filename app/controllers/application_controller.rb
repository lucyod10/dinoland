class ApplicationController < ActionController::Base
  before_action :fetch_user # this means before you do anything, run fetch_user

  private
  # set up an @current_user instance variable if we can find a user_id in this session.
  def fetch_user
      @current_user = User.find_by :id => session[:user_id] if session[:user_id].present?
      session[:user_id] = nil unless @current_user.present?
    end

    def check_for_login
      redirect_to login_path unless @current_user.present?
    end

    def logged_in_send_home
      redirect_to root_path if @current_user.present?
    end

end
