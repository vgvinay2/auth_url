class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  helper_method :current_user
  
  private
  def current_user  
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
  	if session[:user_id]  
  	 	return current_user
  	elsif params[:api_token].present?
        if api_current_user.present?
         return api_current_user
        else 
           render json: { errors: "Please enter correct api_token which u have given" }
        end  
    else
  	   flash[:notice] = 'login in required.'  
  	   redirect_to root_url, :notice => "NO permission to acces  please login first"
  	 end 	
  end 
   def api_current_user
    @current_user ||= User.find_by_api_token(params[:api_token]) 
  end
end
