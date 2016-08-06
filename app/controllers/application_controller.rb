class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  helper_method :current_user
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] && User.pluck(:id).include?(session[:user_id])
  end

  def authenticate_user
  	if session[:user_id] 
  	 	return current_user
  	 else
  	   flash[:notice] = 'login in required.'  
  	   redirect_to root_url, :notice => "NO permission to acces  please login first"
  	 end 	
  end 
end
