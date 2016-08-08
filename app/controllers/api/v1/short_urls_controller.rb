class Api::V1::ShortUrlsController < ApplicationController
  before_action :authenticate_user
  before_action :set_short_url, only: [:show, :destroy]
  # before_action :check_current_user,except: [:index]
 
  # GET /short_urls
  # GET /short_urls.json
  def index
    short_urls = ShortUrl.paginate(:page => params[:page], :per_page => 30).select(:original_url,:short_url,:user_id,:visits_count)
    user = { email: api_current_user.email, token: api_current_user.api_token }  if api_current_user.present?
    render json:  { user: user,short_urls: short_urls, status: "Sucess!!"  }
  end



  def show
    render json:  { short_url: @short_url, status: "Sucess!!"  }
  end
  
   # we require this kind of parameters
   #"short_url"=>{"original_url"=>"http://localhost:3000/short_urls/new", "short_url"=>"http://rock.com", "visits_count"=>"1"}
  
  def create
    if params[:short_url][:original_url].present?
        client = Bitly.client
        @url = client.shorten(params[:short_url][:original_url])
        puts  @url.inspect 
       short_url = api_current_user.short_urls.new(original_url: @url.long_url, short_url:@url.short_url, visits_count: 0 )
        if short_url.save
         render json:  { short_url: short_url, status: "Created"  }
        else
        render json: {  errors: short_url.errors, status: "Failed" } 
        end   
    else
      render json: {  errors: "original_url send proper", status: "Failed" } 
    end
  end

  # DELETE /short_urls/1
  # DELETE /short_urls/1.json
  def destroy
    if @short_url.destroy
     render json: { status: "Deleted" }
    else
     render json: { head: "no content" }
    end 
  end

  private
    
    def set_short_url
      @short_url = ShortUrl.find(params[:id])
    end
    
end
