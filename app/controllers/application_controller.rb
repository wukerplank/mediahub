class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def title
    @title ||= ['MediaHub']
  end
  helper_method :title

  def current_user
    @current_user ||= User.first
  end
  helper_method :current_user

end
