# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region do
    continent "MyString"
    country "MyString"
    state "MyString"
  end
end
