require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :concert do
    random_show = Concert.load_random_show
    state random_show[:state]
    city random_show[:city]
    venue random_show[:venue]
    concert_date random_show[:concert_date]
  end
end
