require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :concert do
    state "VT"
    city "Burlington"
    date_time Time.now
    venue 'Saratoga Performing Arts Center'
  end






end
