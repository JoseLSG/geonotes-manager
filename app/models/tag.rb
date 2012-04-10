# == Schema Information
#
# Table name: tags
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :notes, :uniq => true
 
  validates :name, :presence => true

end
