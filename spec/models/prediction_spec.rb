require 'rails_helper'

# NEED TO DRY THIS UP
def create_concert_songs(new_show)

    ConcertSong.create(
      song_id: Song.find_by(song_name: "Harry Hood").id,
      play_index: 1,
      set_index: 1,
      concert_id: new_show.id,
      songs_in_set: 3
    )

    ConcertSong.create(
    song_id: Song.find_by(song_name: "Suzy Greenberg").id,
    play_index: 2,
    set_index: 1,
    concert_id: new_show.id,
    songs_in_set: 3
    )

    ConcertSong.create(
    song_id: Song.find_by(song_name: "David Bowie").id,
    play_index: 3,
    set_index: 1,
    concert_id: new_show.id,
    songs_in_set: 3
    )

    # second set

    ConcertSong.create(
    song_id: Song.find_by(song_name: "AC/DC Bag").id,
    play_index: 1,
    set_index: 2,
    concert_id: new_show.id,
    songs_in_set: 3
    )

    ConcertSong.create(
    song_id: Song.find_by(song_name: "Run Like an Antelope").id,
    play_index: 2,
    set_index: 2,
    concert_id: new_show.id,
    songs_in_set: 3
    )

    ConcertSong.create(
    song_id: Song.find_by(song_name: "Contact").id,
    play_index: 3,
    set_index: 2,
    concert_id: new_show.id,
    songs_in_set: 3
    )

    # encore
    ConcertSong.create(
    song_id: Song.find_by(song_name: "Chalk Dust Torture").id,
    play_index: 1,
    set_index: 3,
    concert_id: new_show.id,
    songs_in_set: 1
    )

end

def create_concert_prediction(new_show)

  Prediction.create(
    user_id: 1,
    concert_id: new_show.id,
    set_one_opener_song_id: Song.find_by(song_name: "Harry Hood").id,
    set_one_closer_song_id: Song.find_by(song_name: "David Bowie").id,
    set_two_opener_song_id: Song.find_by(song_name: "AC/DC Bag").id,
    set_two_closer_song_id: Song.find_by(song_name: "Contact").id,
    encore_song_id: Song.find_by(song_name: "Chalk Dust Torture").id,
    random_pick_song_id: Song.find_by(song_name: "Run Like an Antelope").id
  )

end

RSpec.describe Prediction, :type => :model do
  it "allows a user to enter a valid prediction" do
    new_show = FactoryGirl.build(:concert)
    new_show.save!

    create_concert_songs(new_show)
    prediction = create_concert_prediction(new_show)

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

  it "Calculates a prediction score for maximum points" do

      new_show = FactoryGirl.build(:concert)
      new_show.save!

      create_concert_songs(new_show)
      prediction = create_concert_prediction(new_show)
      prediction.save!

      expect(prediction.get_prediction_score).to eq(17)
  end
end
