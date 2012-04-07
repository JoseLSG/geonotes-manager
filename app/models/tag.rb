class Tag < ActiveRecord::Base
  has_and_belongs_to_many :notes, :uniq => true
 
    validates :name, :presence    => true

end
