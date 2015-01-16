require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :concert do
    sequence(:concert_date) { |n| "1/#{n}/1995" }
    sequence(:id) { |n| n }
    state 'VT'
    city 'Burlington'
    venue 'Flynn Theatre'
  end
end
