class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_user_from_token!

  respond_to :json

  def create
    user = User.new(user_params)
      if user.save
        update_authentication_token if user.api_token.nil? 
        headers["X-AUTH-TOKEN"] = user.api_token
        short_urls = ShortUrl.paginate(:page => params[:page], :per_page => 30).select(:original_url,:short_url,:user_id,:visits_count)
        # user = { email: user.email, api_token: user.api_token } 
        # render json:  { user_date: user,short_urls: short_urls, status: "Signup successfully!!"  }
        redirect_to api_v1_short_urls_path(api_token: user.api_token )
      else 
        render json:  { errors: user.errors, status: :unprocessable_entity  } 
      end
  end


  
  def destroy
    if user = User.pluck(:id).include?(params[:id])
      user.api_token=nil 
      # headers["X-AUTH-TOKEN"] = nil
      render json: { :info => "Logged out" }
    else
      render json: { :info => "out" }
    end 
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :api_token)
    end
  end