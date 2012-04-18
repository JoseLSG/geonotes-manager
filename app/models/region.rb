# == Schema Information
#
# Table name: regions
#
#  id         :integer(4)      not null, primary key
#  continent  :string(255)
#  country    :string(255)
#  state      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Region < ActiveRecord::Base
  has_many :notes
end
