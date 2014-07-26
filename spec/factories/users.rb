# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	name "Name"
  	sequence(:email) { |n| "user#{n}@antaray.com" }
  	password    "1234567890"
    password_confirmation "1234567890"
  end
end
