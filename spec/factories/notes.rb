# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    user_id 1
    content "test"
    lat 1.0
    lon 1.0
  end
end
