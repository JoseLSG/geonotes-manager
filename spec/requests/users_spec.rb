require 'spec_helper'

describe "Users" do
  
  describe "Sign in" do
    
    before :each do
      @user = FactoryGirl.create(:user)
    end
    
    describe "failure" do
      it "should not proceed to index page" do
        visit new_user_session_path
        fill_in "Username or email",        :with => ""
        fill_in "Password",                 :with => ""
        click_button
        
        response.should render_template('devise/sessions/new')
        response.should have_selector('p.alert', :content => "Invalid")
      end
    end
    
    describe "success" do
      it "should allow access to index page" do
        visit new_user_session_path
        fill_in "Username or email",        :with => @user.email
        fill_in "Password",                 :with => @user.password
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
  
  describe "Profile Update" do
    
    before :all do
      @user = FactoryGirl.build(:user)
    end
    
    before :each do
      sign_in_as_a_valid_user
      visit edit_user_registration_path
    end
    
    describe "failure" do
      
      it "should not allow update without filling-in 'current password'" do       
        click_button "Update"   
        response.should render_template('devise/registrations/edit')
        response.should have_selector('div#error_explanation')
      end
      
    end
    
    describe "success" do
      
      it "should allow update with 'current password' provided" do
        fill_in "user_current_password", :with => @user.password
        click_button "Update"
        
        response.should have_selector('p.notice', :content => "updated")
        response.should render_template('pages/index')
      end
      
      it "should update correctly" do
        @new_attr = {
          :email => "new_test@example.com",
          :password => "new_pass"
        }

        fill_in "Email", :with => @new_attr[:email]
        fill_in "user_current_password", :with => @user.password
        click_button "Update"
        
        @modified_user = User.find(@user.id)
        @modified_user.email.should eql @new_attr[:email]
      end
      
    end
    
    describe "Cancel Account" do
      
      it "should cancel account correctly" do
        click_link "Cancel"
       # click_button "OK"
        response.should render_template('pages/index')
      end
      
    end  
  end
  
  describe "Map Page" do
    
    before :each do
      sign_in_as_a_valid_user
      visit map_path
    end
    
    it "should go to Menu page after clicking 'Menu' link" do
      click_link "Menu"
      response.should render_template('pages/index')
    end
    
    it "should go to notes page after clicking 'Notes' link" do
      click_link "Notes"
      response.should render_template('notes/index')
    end
    
  end
  
    
  describe "Menu Page" do
    
    before :each do
      sign_in_as_a_valid_user
      visit users_path
    end
    
    it "should go to map page after clicking 'Map' link" do
      click_link "Map"
      response.should render_template('pages/show_map')
    end
    
    it "should go to notes page after clicking 'Notes' link" do
      click_link "Notes"
      response.should render_template('notes/index')
    end
    
    it "should go to profile page after clicking 'Profile' link" do
      click_link "Profile"
      response.should render_template('devise/registrations/edit')
    end
  end
  
  describe "Notes Page" do
    
    before :each do
      sign_in_as_a_valid_user
      @note = FactoryGirl.create(:note)
      visit notes_path
    end
    
    it "should go to map page after clicking 'Menu' link" do
      click_link "Menu"
      response.should render_template('pages/index')
    end
    
    it "should go to map page after clicking 'Map' link" do
      click_link "Map"
      response.should render_template('pages/show_map')
    end
    
    
    it "should go to 'edit note' page after clicking on a note" do
      click_link @note.content
      response.should render_template('notes/show')
    end
    
  end
  
end