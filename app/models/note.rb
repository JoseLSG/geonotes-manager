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
  set_rgeo_factory_for_column(:geolocation, RGeo::Geographic.spherical_factory)
  
end
