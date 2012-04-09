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
  belongs_to :user
  has_and_belongs_to_many :tags, :uniq => true
  
  set_rgeo_factory_for_column(:geolocation, RGeo::Geographic.spherical_factory)
  
  validates :geolocation, :presence => true
  validates :user_id, :presence => true
  
  attr_accessor :lat, :lon, :tag_list
  
  before_validation :set_geolocation
  before_save :save_tags
  
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
  
  def save_tags
    self.tags = tag_list.split(/\s*,\s*/).uniq.map{ |tag_name| 
                  Tag.find_or_create_by_name(:name => tag_name)
                }
  end
  
  def set_geolocation
    self.geolocation = RGeo::Geographic.spherical_factory.point(lon, lat)
  end
   
end
