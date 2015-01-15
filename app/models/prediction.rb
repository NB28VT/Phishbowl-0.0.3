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

  validates :set_one_opener_song_id,
    presence: true
  validates :set_one_closer_song_id,
    presence: true
  validates :set_two_opener_song_id,
    presence: true
  validates :set_two_closer_song_id,
    presence: true
  validates :encore_song_id,
    presence: true
  validates :random_pick_song_id,
    presence: true
end
