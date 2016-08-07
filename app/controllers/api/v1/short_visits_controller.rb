class Api::V1::ShortVisitsController < ApplicationController
  require 'rest_client'
  # for each request send a token to authenticate user
  before_action :authenticate_user
  before_action :set_short_visit, only: [:show, :edit, :update, :destroy]
  before_action  :set_short_url,only: [:create] 
 
  def show
  end
  
  # POST /short_visits
  # POST /short_visits.json
  def create
    ip = remote_ip
    geolocation_data = RestClient.get "freegeoip.net/json/#{ip}"
    @geolocation_data = JSON.parse(geolocation_data, :symbolize => true) 
    if @short_url.present? 
    short_visit = @short_url.short_visits.create(visitor_ip: geolocation_data["ip"], visitor_city: geolocation_data["city"],visitior_state: geolocation_data["country_name"],visitor_country_iso: geolocation_data["country_code"])
    render json: {  short_visit: short_visit, status: "Created" } 
    else
      render json: {  errors: "something went wrong" , status: "failed" } 
    end   
  end

  # PATCH/PUT /short_visits/1
  # PATCH/PUT /short_visits/1.json
  def update
    respond_to do |format|
      if @short_visit.update(short_visit_params)
        format.html { redirect_to @short_visit, notice: 'Short visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @short_visit }
      else
        format.html { render :edit }
        format.json { render json: @short_visit.errors, status: :unprocessable_entity }
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_visit
      @short_visit = ShortVisit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def short_visit_params
      params.require(:short_visit).permit(:short_url_id, :visitor_ip, :visitor_city, :visitior_state, :visitor_country_iso, :latitude, :longitude)
    end
    def set_short_url
      @short_url = ShortUrl.find_by_id(params[:short_url_id])
    end 
end