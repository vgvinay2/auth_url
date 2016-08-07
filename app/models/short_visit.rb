class ShortVisit < ActiveRecord::Base
  belongs_to :short_url, dependent:  :destroy

  geocoded_by :visitor_ip  # can also be an IP address
  after_validation :geocode # auto-fetch coordinates  
  
   reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.visitor_city = geo.address
      obj.visitior_state = geo.state
      obj.visitor_country_iso = geo.country
    end
  end
 after_validation :reverse_geocode  # auto-fetch address
end
