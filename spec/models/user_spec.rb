# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  username               :string(255)
#

require 'spec_helper'

describe User do
  
  before :each do
    @user = FactoryGirl.build(:user)
  end
  
  it "should create an instance with valid attributes" do
    @user.save!
  end
  
  describe "emails" do
    
    it "should require an email" do
      @user.email= ""
      @user.should_not be_valid
    end
    
    it "should accept valid emails" do
      emails = %w[user@foo.com THE_USER@food.bar.org first.last@foo.jp]
      emails.each do |email|
        @user.email = email
        @user.should be_valid
      end
    end
    
    it "should reject invalid emails" do
      emails = %w[user@foo,com THE_USERfood.bar.org first.last@foo.]
      emails.each do |email|
        @user.email = email
        @user.should_not be_valid
      end
    end
    
  end
  
  describe "passwords" do
    
    it "should require a password" do
      @user.password= ""
      @user.should_not be_valid
    end

    it "should require a password_confirmation" do
      @user.password_confirmation = ""
      @user.should_not be_valid
    end

    it "should require a matching password_confirmation" do
      @user.should be_valid
      @user.password_confirmation = "invalid"
      @user.should_not be_valid
    end
    
    it "should reject short passwords" do
      long = "a" * 5
      @user.password, @user.password_confirmation = long, long
      @user.should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 129
      @user.password, @user.password_confirmation = long, long
      @user.should_not be_valid
    end
    
  end
  
  
end
