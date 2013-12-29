FactoryGirl.define do
  factory :user do
    name "Example"
    password "password"
    password_confirmation "password"
    email "sample@example.com"
  end
end