require 'spec_helper'

describe "Layout" do
  
  describe "Sign in" do
    
    before :each do
      get new_user_session_path
    end
    
    it "should have a 'GeoNotes Manager' title" do
      response.should have_selector('h1', :content => "GeoNotes Manager")
    end
    
    it "should have an email input section" do
      response.should have_selector('div #email_section label', :content => "Email")
      response.should have_selector('div #email_section input', :type => "email")
    end
    
    it "should have an password input section" do
      response.should have_selector('div #password_section label', :content => "Password")
      response.should have_selector('div #password_section input', :type => "password")
    end
    
    it "should have a 'Sign in' button" do
      response.should have_selector('div #user_submit', :type => "submit", :value => "Sign in")
    end
    
    it "should have a 'Sign up' button" do
      response.should have_selector('a', :content => "Sign up")
    end
    
    it "should have a 'forgot pass' button" do
      response.should have_selector('a', :content => "Forgot your password?")
    end
    
  end
  
  describe "Registration" do
    
    before :each do
      get new_user_registration_path
    end
    
    it "should have a 'Registration' title" do
      response.should have_selector('h1', :content => "Registration")
    end
    
    it "should have a 'back' button" do
      response.should have_selector('a', :content => "Back")
    end
    
    it "should have a 'Registration' title" do
      response.should have_selector('h1', :content => "Registration")
    end
    
    it "should have an email input section" do
      response.should have_selector('div #email_section label', :content => "Email")
      response.should have_selector('div #email_section input', :type => "email")
    end
    
    it "should have an password input section" do
      response.should have_selector('div #password_section label', :content => "Password")
      response.should have_selector('div #password_section input', :type => "password")
    end
    
    it "should have an password confirmation input section" do
      response.should have_selector('div #password_confirmation_section', :content => "Password confirmation")
      response.should have_selector('div #password_confirmation_section input', :type => "password")
    end
    
    it "should have a 'Register' button" do
      response.should have_selector('div #user_submit', :type => "submit", :value => "Register")
    end
    
  end
  
  describe "Password retrival" do
    
    before :each do
      get new_user_password_path
    end
    
    it "should have a 'Password Reset' title" do
      response.should have_selector('h1', :content => "Password Reset")
    end
    
    it "should have a 'back' button" do
      response.should have_selector('a', :content => "Back")
    end
    
    it "should have a 'Password Reset' title" do
      response.should have_selector('h1', :content => "Password Reset")
    end
    
    it "should have an email input section" do
      response.should have_selector('div #email_section label', :content => "Email")
      response.should have_selector('div #email_section input', :type => "email")
    end
    
    it "should have a 'send instructions' button" do
      response.should have_selector('div #user_submit', :type => "submit", :value => "Send me reset password instructions")
    end

  end
  
  describe "Main Menu" do
    
    before :each do
      sign_in_as_a_valid_user
      get "/"
    end
    
    it "should have a 'Main Menu' title" do
      response.should have_selector('h1', :content => "Main Menu")
    end
    
    it "should have a 'Sign out' button" do
      response.should have_selector('a', :content => "Sign out")
    end
    
    it "should have a 'Map' button" do
      response.should have_selector('a', :content => "Map")
    end
    
    it "should have a 'Notes' button" do
      response.should have_selector('a', :content => "Notes")
    end
    
    it "should have a 'Profile' button" do
      response.should have_selector('a', :content => "Profile")
    end
    
  end

end
