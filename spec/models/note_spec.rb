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

require 'spec_helper'

describe Note do

end
