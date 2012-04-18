# == Schema Information
#
# Table name: locals
#
#  id         :integer(4)      not null, primary key
#  city       :string(255)
#  borough    :string(255)
#  street     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Local < ActiveRecord::Base
  has_many :notes
end
