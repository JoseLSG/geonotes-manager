# This library forwards geographical coordinates to the external web service geonames.org
# and returns the information requestions in ruby object format
#
# Author: Jose Luis Saldivar

module Geoinfo
  include HTTParty
  base_uri 'http://api.geonames.org'
  USERNAME = 'geonotes2'
  STREET_MAX_DISTANCE = 0.1
  
  def coordinates(lat,lon)
    @lat = lat
    @lon = lon
    # puts "lat=#{@lat}&lng=#{@lon}"
  end
  
  def nearest_street
    list = nearby_streets
    street = nil

    if list.class == Hash  #if the list has only 1 element, its going to be a hash and not array class
      street = list
    else
      street = list.first if !list.nil?
      #street = list.sort_by{|x| x[:distance.to_s]}.first # no need for sorting, web service sorts them asc
    end
    
    if street.nil?
      nil
    else
      (street.symbolize_keys![:distance].to_f < STREET_MAX_DISTANCE)? street : nil
    end
  end
  
  # returns an array of nearby streets info
  def nearby_streets
    nearby_streets = Geoinfo.get('/findNearbyStreetsOSM',:query => {:lat => @lat, :lng => @lon, :username => USERNAME})["geonames"]
    nearby_streets.nil? ? nil : nearby_streets["streetSegment"]
  end
  
  # returns a Hash of nearby location info with symbols as keys
  def location_info
    location_info = extended_nearby_info
    
    if !location_info.nil? 
      { :continent  => location_info[1]["toponymName"],
        :country    => location_info[2]["toponymName"],
        :state      => location_info[3]["toponymName"],
        :city       => location_info[4]["toponymName"],
        :borough    => (location_info[5]["toponymName"] unless location_info.length < 6) }
    end
  end
  
  # returns an array of near_by location info
  def extended_nearby_info
    Geoinfo.get('/extendedFindNearby',:query => {:lat => @lat, :lng => @lon, :username => USERNAME})["geonames"]["geoname"]
  end

end