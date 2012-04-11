FactoryGirl.define do
  
  factory :user do
    id                     1
    username               "test"
    email                  "test@example.com"
    password               "example"
    password_confirmation  "example"
  end
  
end