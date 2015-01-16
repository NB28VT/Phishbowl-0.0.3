require 'rails_helper'

RSpec.describe Prediction, :type => :model do
  it "allows a user to enter a valid prediction" do
    prediction = Prediction.new
    concert = FactoryGirl.build(:concert)
    concert.save
    user = FactoryGirl.build(:user)
    user.save!

    prediction.user_id = user.id
    prediction.concert_id =
    prediction.set_one_opener_song_id = 3
    prediction.set_one_closer_song_id = 1
    prediction.set_two_opener_song_id = 2
    prediction.set_two_closer_song_id = 2
    prediction.encore_song_id = 4
    prediction.random_pick_song_id = 5

    expect(prediction.save).to eq(true)
  end

  it "does not allow a user to leave a blank field in a prediction" do
    prediction = Prediction.new

    prediction.set_one_closer_song_id = 1
    prediction.set_two_opener_song_id = 2
    prediction.set_one_opener_song_id = 3
    prediction.encore_song_id = 4
    prediction.random_pick_song_id = 5

    expect(prediction.save).to eq(false)
  end


end
