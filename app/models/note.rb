# == Schema Information
#
# Table name: notes
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  content    :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  region_id  :integer(4)
#  local_id   :integer(4)
#

class Note < ActiveRecord::Base
  include Geoinfo
    
  belongs_to :user
  belongs_to :region
  belongs_to :local
  has_and_belongs_to_many :tags, :uniq => true
  
  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :user_id, :presence => true
  
  attr_accessor :lat, :lon, :tag_list
  
  before_validation :set_geolocation
  before_save :save_attributes
  
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
    coordinates(latitude, longitude)
    
    ns = nearest_street
    li = location_info

   self.region = Region.where(
                    :continent  => li[:continent],
                    :country    => li[:country],
                    :state      => li[:state]
                  ).first_or_create unless li.nil?
                  
   self.local = Local.where(
                  :city     => (li[:city] unless li.nil?),
                  :borough  => (li[:borough] unless li.nil?),
                  :street   => (ns[:name] unless ns.nil?)
                ).first_or_create
  end
  
  def save_tags
    self.tags = tag_list.split(/\s*,\s*/).uniq.map{ |tag_name| 
                  Tag.find_or_create_by_name(:name => tag_name)
                }             
  end
  
  def set_geolocation
    self.latitude ||= lat
    self.longitude ||= lon
  end

end
