class Prediction < ActiveRecord::Base
  belongs_to :concert,  class_name: "Concert", foreign_key: "concert_id"
  belongs_to :user

  belongs_to :set_one_opener_song,
    class_name: "Song", foreign_key: "set_one_opener_song_id"
  belongs_to :set_one_closer_song,
   class_name: "Song", foreign_key: "set_one_closer_song_id"
  belongs_to :set_two_opener_song,
   class_name: "Song", foreign_key: "set_two_opener_song_id"
  belongs_to :set_two_closer_song,
   class_name: "Song", foreign_key: "set_two_closer_song_id"
  belongs_to :encore_song,
   class_name: "Song", foreign_key: "encore_song_id"
  belongs_to :random_pick_song,
   class_name: "Song", foreign_key: "random_pick_song_id"

  validates_presence_of :set_one_opener_song_id
  validates_presence_of :set_one_closer_song_id
  validates_presence_of :set_two_opener_song_id
  validates_presence_of :set_two_closer_song_id
  validates_presence_of :encore_song_id
  validates_presence_of :random_pick_song_id

  def get_prediction_score

    prediction_score = 0
    # returns a list of concert_song_objects
    actual_setlist = self.concert.concert_songs

    # !!!! Again what to do with encores?


    # Find song object for place in set
    actual_set_one_opener = Song.find_by(
      id:(actual_setlist.find_by(play_index: 1, set_index: 1).song_id))

    actual_set_two_opener = Song.find_by(
      id:(actual_setlist.find_by(play_index: 2, set_index: 1).song_id))


    if Song.find_by(
      id:(actual_setlist.find_by(set_index: 3)))

      actual_encore = Song.find_by(
      id:(actual_setlist.find_by(set_index: 3).song_id))
    end

    binding.pry











  end

end
