require 'spec_helper'

describe PagesController do
  
  render_views

  describe "authentication of pages" do
    
    describe "for non-signed-in users" do
      
      it "should deny access to 'index'" do
        get :index
        response.should redirect_to(new_user_session_path)
      end
      
    end
    
    describe "for signed-in users" do
      
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      
      it "should grant access to 'index'" do
        get :index
        response.should render_template("index")
      end

    end
    
  end

end
