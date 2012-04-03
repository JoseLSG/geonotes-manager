require 'spec_helper'

describe NotesController do

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
        signed_in_as_a_valid_user
      end
      
      it "should grant access to 'index'" do
        get :index
        response.should render_template("index")
      end

    end
    
  end

end
