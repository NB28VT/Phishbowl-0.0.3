require 'rails_helper'

RSpec.describe Prediction, :type => :model do
  it "allows a user to enter a valid prediction" do
    prediction = Prediction.new

    prediction.user_id = 1
    prediction.concert_id = 1
    prediction.set_one_opener_song_id = 1
    prediction.set_one_closer_song_id = 2
    prediction.set_two_opener_song_id = 3
    prediction.set_two_closer_song_id = 4
    prediction.encore_song_id = 5
    prediction.random_pick_song_id = 1

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

  it "Calculates a prediction score" do

    50.times do
      Concert.create_random_show

      new_show = Concert.first

      prediction = Prediction.new

      prediction.user_id = 1
      prediction.concert_id = new_show.id
      prediction.set_one_closer_song_id = 123
      prediction.set_two_opener_song_id = 234
      prediction.set_one_opener_song_id = 456
      prediction.encore_song_id = 567
      prediction.random_pick_song_id = 345
      prediction.get_prediction_score
    end
  end











end
