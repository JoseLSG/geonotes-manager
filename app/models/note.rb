# == Schema Information
#
# Table name: notes
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  content     :string(255)
#  geolocation :spatial({:type=
#  created_at  :datetime
#  updated_at  :datetime
#

class Note < ActiveRecord::Base
  include Geoinfo
    
  belongs_to :user
  belongs_to :region
  belongs_to :local
  has_and_belongs_to_many :tags, :uniq => true
  
  set_rgeo_factory_for_column(:geolocation, RGeo::Geographic.spherical_factory)
  
  validates :geolocation, :presence => true
  validates :user_id, :presence => true
  
  attr_accessor :lat, :lon, :tag_list
  
  before_validation :set_geolocation
  before_save :save_attributes
  
  def lat
    read_attribute(:lat) || geolocation.latitude
  end
  
  def lat=(value)
    write_attribute(:lat, value)
  end
  
  def lon
    read_attribute(:lon) || geolocation.longitude
  end
    
  def lon=(value)
    write_attribute(:lon, value)
  end
  
  def tag_list
    read_attribute(:tag_list) || tags.map{|t| t.name }.join(", ")
  end
  
  def tag_list=(value)
    write_attribute(:tag_list, value)
  end
  
  private
  
  def save_attributes
    save_tags
    save_location
  end
  
  def save_location
    coordinates(self.lat, self.lon)
    
    ns = nearest_street
    li = location_info
    puts ns
    puts li
    
   self.region = Region.where(
                    :continent  => li[:continent],
                    :country    => li[:country],
                    :state      => li[:state]
                  ).first_or_create
                  
   self.local = Local.where(
                  :city     => li[:city],
                  :borough  => li[:borough],
                  :street   => ns[:name]
                ).first_or_create
                
    puts self.region.inspect
    puts self.local.inspect

  end
  
  def save_tags
    self.tags = tag_list.split(/\s*,\s*/).uniq.map{ |tag_name| 
                  Tag.find_or_create_by_name(:name => tag_name)
                }
  end
  
  def set_geolocation
    self.geolocation = RGeo::Geographic.spherical_factory.point(lon, lat)
  end

end
