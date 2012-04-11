module ValidUserHelper
  
  def signed_in_as_a_valid_user
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  
end

module ValidUserRequestHelper
  
  def sign_in_as_a_valid_user
    sign_in_as_a_valid_user_with_email
    # also valid: 
    # sign_in_as_a_valid_user_with_username
  end
  
  def sign_in_as_a_valid_user_with_username
    @user = FactoryGirl.create(:user)
    post_via_redirect user_session_path, :user => {:login => @user.username, :password => @user.password}
  end
  
  def sign_in_as_a_valid_user_with_email
    @user = FactoryGirl.create(:user)
    post_via_redirect user_session_path, :user => {:login => @user.email, :password => @user.password}
  end
  
end

RSpec.configure do |config|
  config.include ValidUserHelper, :type => :controller
  config.include ValidUserRequestHelper, :type => :request
end