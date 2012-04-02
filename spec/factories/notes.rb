# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    user_id ""
    content "MyString"
    geolocation ""
  end
end
