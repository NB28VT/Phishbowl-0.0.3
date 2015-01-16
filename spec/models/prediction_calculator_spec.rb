require 'rails_helper'

def concert_song_builder(song_name, play_index, set_index, new_show, songs_in_set)
  ConcertSong.create(
  song_id: Song.find_by(song_name: song_name).id,
  play_index: play_index,
  set_index: set_index,
  concert_id: new_show.id,
  songs_in_set: songs_in_set
  )
end

def create_concert_songs(new_show)

  first_set_songs = ["Harry Hood", "Suzy Greenberg", "David Bowie"]
  second_set_songs = ["AC/DC Bag", "Run Like an Antelope", "Contact"]

  play_index = 1
  first_set_songs.each do |song|
    concert_song_builder(song, play_index, 1, new_show, first_set_songs.count)
    play_index += 1
  end

  play_index = 1
  second_set_songs.each do |song|
    concert_song_builder(song, play_index, 2, new_show, first_set_songs.count)
    play_index += 1
  end

  # build encore song
  concert_song_builder("Chalk Dust Torture", 1, 3, new_show, 1)

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


RSpec.describe PredictionCalculator, :type => :model do

  it "Calculates a prediction score for maximum points" do

    new_show = FactoryGirl.build(:concert)
    new_show.save!

    create_concert_songs(new_show)
    prediction = create_concert_prediction(new_show)
    calculator = PredictionCalculator.new

    expect(calculator.get_prediction_score(prediction)).to eq(17)
  end
end
