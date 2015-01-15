class Prediction < ActiveRecord::Base
  belongs_to :concert,  class_name: "Concert", foreign_key: "concert_id"
  belongs_to :user

  belongs_to :set_one_opener_song,
    class_name: "Song",
    foreign_key: "set_one_opener_song_id"

  belongs_to :set_one_closer_song,
   class_name: "Song",
   foreign_key: "set_one_closer_song_id"

  belongs_to :set_two_opener_song,
   class_name: "Song",
   foreign_key: "set_two_opener_song_id"

  belongs_to :set_two_closer_song,
   class_name: "Song",
   foreign_key: "set_two_closer_song_id"

  belongs_to :encore_song,
   class_name: "Song", foreign_key: "encore_song_id"
  belongs_to :random_pick_song,
   class_name: "Song", foreign_key: "random_pick_song_id"

   #use foxy validations
  validates_presence_of :set_one_opener_song
  validates_presence_of :set_one_closer_song_id
  validates_presence_of :set_two_opener_song_id
  validates_presence_of :set_two_closer_song_id
  validates_presence_of :encore_song_id
  validates_presence_of :random_pick_song_id


end
