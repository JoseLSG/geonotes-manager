# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    user_id 1
    content "test"
    geolocation RGeo::Geographic.spherical_factory.point(0, 0)
  end
end
