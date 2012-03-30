module ValidUserHelper
  
  def signed_in_as_a_valid_user
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  
end

module ValidUserRequestHelper
  
  def sign_in_as_a_valid_user
    @user = FactoryGirl.create(:user)
    post_via_redirect user_session_path, :user => {:email => @user.email, :password => @user.password}
  end
  
end

RSpec.configure do |config|
  config.include ValidUserHelper, :type => :controller
  config.include ValidUserRequestHelper, :type => :request
end