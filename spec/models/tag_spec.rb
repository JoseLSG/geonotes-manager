# == Schema Information
#
# Table name: tags
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Tag do
  it "should require a tag name" do
    @tag = FactoryGirl.build(:tag)
    @tag.name = ""
    @tag.should_not be_valid
  end
end
