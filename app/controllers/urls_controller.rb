class UrlsController < ApplicationController
	# bitly implementation  https://richonrails.com/articles/shortening-urls-with-bit-ly

  def new
  end

 def create
    if !params[:url].blank?
      client = Bitly.client
      @url = client.shorten(params[:url])
     puts  @url.inspect 
    end
  end
end
