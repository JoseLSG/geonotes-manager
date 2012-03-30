require 'spec_helper'

describe "Users" do
  
  describe "Sign in" do
    
    before :each do
      @user = FactoryGirl.create(:user)
    end
    
    describe "failure" do
      it "should not proceed to index page" do
        visit new_user_session_path
        fill_in "Email",        :with => ""
        fill_in "Password",     :with => ""
        click_button
        
        response.should render_template('devise/sessions/new')
        response.should have_selector('p.alert', :content => "Invalid")
      end
    end
    
    describe "success" do
      it "should allow access to index page" do
        visit new_user_session_path
        fill_in "Email",        :with => @user.email
        fill_in "Password",     :with => @user.password
        click_button
        
        response.should have_selector('p.notice', :content => "Signed in")
        response.should render_template('pages/index')
      end
    end
    
  end
  
  describe "Registration" do
    
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit new_user_registration_path
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "user_password_confirmation", :with => ""
          click_button
          
          response.should render_template('devise/registrations/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit new_user_registration_path
          fill_in "Email",        :with => "test@example.com"
          fill_in "Password",     :with => "123456"
          fill_in "user_password_confirmation", :with => "123456"
          click_button
          
          response.should have_selector('p.notice', :content => "Welcome")
          response.should render_template('pages/index')
        end.should change(User, :count).by(1)
      end
    end
    
  end
end