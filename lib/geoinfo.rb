# This library forwards geographical coordinates to the external web service geonames.org
# and returns the information requestions in ruby object format
#
# Author: Jose Luis Saldivar

module Geoinfo
  include HTTParty
  base_uri 'http://api.geonames.org'
  USERNAME = 'geonotes2'
  STREET_MAX_DISTANCE= 0.1
  
  def coordinates(lat,lon)
    @lat = lat
    @lon = lon
    puts "lat=#{@lat}&lng=#{@lon}"
  end
  
  def nearest_street
    list = nearby_streets
    street = nil

    if list.class == Hash  #if the list has only 1 element, its going to be a hash and not array class
      street = list
    else
      street = list.sort_by{|x| x[:distance.to_s]}.first
    end
    
    (street[:distance.to_s].to_f < STREET_MAX_DISTANCE)? street : nil
  end
  
  def nearby_streets
    nearby_streets = Geoinfo.get('/findNearbyStreetsOSM',:query => {:lat => @lat, :lng => @lon, :username => USERNAME})["geonames"]
    nearby_streets.nil? ? nil : nearby_streets["streetSegment"]
  end
  
  def location_info
    location_info = extended_nearby_info

    { :continent  => location_info[1][:toponymName.to_s],
      :country    => location_info[2][:toponymName.to_s],
      :state      => location_info[3][:toponymName.to_s],
      :city       => location_info[4][:toponymName.to_s],
      :borough    => (location_info[5][:toponymName.to_s] unless location_info.length < 6) }
  end
  
  def extended_nearby_info
    Geoinfo.get('/extendedFindNearby',:query => {:lat => @lat, :lng => @lon, :username => USERNAME})["geonames"]["geoname"]
  end

end