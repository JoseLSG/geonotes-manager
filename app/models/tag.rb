# == Schema Information
#
# Table name: tags
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :notes, :uniq => true
 
  validates :name, :presence => true

end
