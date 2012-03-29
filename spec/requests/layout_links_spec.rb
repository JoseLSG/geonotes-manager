require 'spec_helper'

describe "Layout" do
  
  describe "Sign in" do
    
    it "should have a 'GeoNotes Manager' title" do
      get new_user_session_path
      response.should have_selector('h1', :content => "GeoNotes Manager")
    end
    
    it "should have a 'Sign in' button" do
      get new_user_session_path
      response.should have_selector('div #user_submit', :type => "submit", :value => "Sign in")
    end
    
    it "should have a 'Sign up' button" do
      get new_user_session_path
      response.should have_selector('a', :content => "Sign up")
    end
    
    it "should have a 'forgot pass' button" do
      get new_user_session_path
      response.should have_selector('a', :content => "Forgot your password?")
    end
    
  end

end
