class Api::V1::ShortUrlsController < ApplicationController
  before_action :authenticate_user
  before_action :set_short_url, only: [:show, :edit, :update, :destroy]
  # before_action :check_current_user,except: [:index]
 
  # GET /short_urls
  # GET /short_urls.json
  def index
    short_urls = ShortUrl.paginate(:page => params[:page], :per_page => 30).select(:original_url,:short_url,:user_id,:visits_count)
    user = { email: api_current_user.email, token: api_current_user.api_token }  if api_current_user.present?
    render json:  { user: user,short_urls: short_urls, status: "Sucess!!"  }
  end



  # GET /short_urls/1/edit
  def edit
     render json:  { short_url: @short_url, status: "edit form "  }
  end
# we require this kind of parameters
#"short_url"=>{"original_url"=>"http://localhost:3000/short_urls/new", "short_url"=>"http://rock.com", "visits_count"=>"1"}
  def create
    short_url = api_current_user.short_urls.new(short_url_params)
    if short_url.save
      render json:  { short_url: short_url, status: "created"  }
    else
      render json: {  errors: short_url.errors, status: "failed" } 
    end
  end

  # PATCH/PUT /short_urls/1
  # PATCH/PUT /short_urls/1.json
  def update
      if @short_url.update(short_url_params)
       render json: { short_url: @short_url, status: "updated"  }
      else
        render json:  { errors: @short_url.errors, status: "Failed" }
      end
  end

  # DELETE /short_urls/1
  # DELETE /short_urls/1.json
  def destroy
    if @short_url.destroy
     render json: { status: "succesfully deleted" }
    else
     render json: { head: "no_content" }
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def check_current_user
    #   if params[:api_token].present? && User.find_by_api_token(params[:api_token])
    #     api_current_user 
    #   else
    #     render json: { errors: "Please enter correct api_token which u have given" }   
    #   end 
    # end
    
    def set_short_url
      @short_url = ShortUrl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_url_params
      params.require(:short_url).permit(:original_url, :short_url, :visits_count)
    end
end
