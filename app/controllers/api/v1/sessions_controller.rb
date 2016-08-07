class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_user_from_token!

  respond_to :json

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      # session[:user_id] = user.id
       update_authentication_token if user.api_token.nil? 
       headers["X-AUTH-TOKEN"] = user.api_token
       render json: { message: "Logged in!",status: "Success",user: user }
    else
      render json: { message: "please enter correct email and pasword", head: 401 }
    end
  end

  
  def destroy
    if user = User.find_by_id(params[:id])
      user.api_token = nil 
      # headers["X-AUTH-TOKEN"] = nil
      render json: { :message => "Logged out" }
    else
      render json: { :message => "out" }
    end 
  end
 end