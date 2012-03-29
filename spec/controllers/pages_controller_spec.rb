require 'spec_helper'

describe PagesController do
  
  render_views

  describe "authentication of pages" do
    
    before :all do
      @attr = {
        :email => "test@example.com",
        :password => "example"
      }

      @user = User.create(@attr)

    end
    
    describe "for non-signed-in users" do
      
      it "should deny access to 'index'" do
        get :index
        response.should redirect_to(new_user_session_path)
      end
      
    end
    
    describe "for signed-in users" do
      it "should grant access to 'index'" do
        sign_in @user
        response.should be_success
      end
    end
    
  end
  
  

end
