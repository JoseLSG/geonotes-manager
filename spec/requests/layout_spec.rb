require 'spec_helper'

describe "Layout" do
  
  describe "Login" do
    
    it "should be able to allow access with an username" do
      sign_in_as_a_valid_user_with_username
      get "/"
    end
    
    it "should be able to allow access with an email" do
      sign_in_as_a_valid_user_with_email
      get "/"
    end
    
  end
  
  describe "Sign in" do
    
    before :each do
      get new_user_session_path
    end
    
    it "should have a 'GeoNotes Manager' title" do
      response.should have_selector('h1', :content => "GeoNotes")
    end
    
    it "should have a login input section" do
      response.should have_selector('div #login_section label', :content => "Username")
      response.should have_selector('div #login_section input', :type => "text")
    end
    
    it "should have an password input section" do
      response.should have_selector('div #password_section label', :content => "Password")
      response.should have_selector('div #password_section input', :type => "password")
    end
    
    it "should have a 'Sign in' button" do
      response.should have_selector('input', :type => "submit", :value => "Sign in")
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
    
    it "should have an login input section" do
      response.should have_selector('div #login_section label', :content => "Username")
      response.should have_selector('div #login_section input', :type => "text")
      response.should have_selector('div #login_section label', :content => "Email")
      response.should have_selector('div #login_section input', :type => "email")
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
      response.should have_selector('input', :type => "submit", :value => "Register")
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
    
    it "should have a login input section" do
      response.should have_selector('div #login_section label', :content => "Username")
      response.should have_selector('div #login_section label', :content => "email")
      response.should have_selector('div #login_section input', :type => "text")
    end
    
    it "should have a 'send instructions' button" do
      response.should have_selector('input', :type => "submit", :value => "Send me reset password instructions")
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
      response.should have_selector('input', :value => "Sign out")
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
  
  describe "Profile Page" do
    
    before :each do
      sign_in_as_a_valid_user
      get edit_user_registration_path
    end
    
    it "should have a 'Profile' title" do
      response.should have_selector('h1', :content => "Profile")
    end
    
    it "should have a 'back' button" do
      response.should have_selector('a', :content => "Back")
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
    
    it "should have a current password input section" do
      response.should have_selector('div #current_password_section', :content => "Current password")
      response.should have_selector('div #current_password_section input', :type => "password")
    end
    
    it "should have a 'cancel account' button" do
      response.should have_selector('input#Cancel')
    end
    
  end
  
  describe "Map Page" do
    
    before :each do
      sign_in_as_a_valid_user
      get map_path
    end
    
    it "should have a 'Map' title" do
      response.should have_selector('h1', :content => "Map")
    end
    
    it "should have a 'Menu' button" do
      response.should have_selector('a', :content => "Menu")
    end
    
    it "should have a 'Notes' button" do
      response.should have_selector('a', :content => "Notes")
    end
    
  end
  
  describe "Notes Page" do
    
    before :each do
      sign_in_as_a_valid_user
      get notes_path
    end
    
    it "should have a 'Notes' title" do
      response.should have_selector('h1', :content => "Notes")
    end
    
    it "should have a 'Menu' button" do
      response.should have_selector('a', :content => "Menu")
    end
    
    it "should have a 'Map' button" do
      response.should have_selector('a', :content => "Map")
    end
    
    it "should have a content links" do
      @note = FactoryGirl.create(:note)
      get notes_path
      response.should have_selector('a', :href => note_path(@note))
    end
  end

end
