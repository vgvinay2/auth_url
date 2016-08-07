class ShortVisitsController < ApplicationController
  before_action :authenticate_user
  before_action :set_short_visit, only: [:show, :edit, :update, :destroy]

  # GET /short_visits
  # GET /short_visits.json
  def index
    @short_visits = ShortVisit.all
  end

  # GET /short_visits/1
  # GET /short_visits/1.json
  def show
  end

  # GET /short_visits/new
  def new
    @short_visit = ShortVisit.new
  end

  # GET /short_visits/1/edit
  def edit
  end

  # POST /short_visits
  # POST /short_visits.json
  def create
    # request.remote_ip
    # request.env['HTTP_X_REAL_IP']
    @short_visit = ShortVisit.create(visitor_ip: params[:short_visit][:visitor_ip] )
    # Location.create(:zip => params["location"]["zip"], :city => params["location"]["city"])
    respond_to do |format|
      if @short_visit.save
        format.html { redirect_to @short_visit, notice: 'Short visit was successfully created.' }
        format.json { render :show, status: :created, location: @short_visit }
      else
        format.html { render :new }
        format.json { render json: @short_visit.errors, status: :unprocessable_entity }
      end
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

  # DELETE /short_visits/1
  # DELETE /short_visits/1.json
  def destroy
    @short_visit.destroy
    respond_to do |format|
      format.html { redirect_to short_visits_url, notice: 'Short visit was successfully destroyed.' }
      format.json { head :no_content }
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
end
