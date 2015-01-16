class Song < ActiveRecord::Base
  has_many :set_one_opener_predictions,
    class_name: 'Prediction',
    foreign_key: 'set_one_opener_song_id'

  has_many :set_one_closer_predictions,
    class_name: 'Prediction',
    foreign_key: 'set_one_closer_song_id'

  has_many :set_two_opener_predictions,
    class_name: 'Prediction',
    foreign_key: 'set_two_opener_song_id'

  has_many :set_two_closer_predictions,
    class_name: 'Prediction',
    foreign_key: 'set_two_closer_song_id'

  has_many :encore_predictions,
    class_name: 'Prediction',
    foreign_key: 'encore_song_id'

  has_many :random_pick_predictions,
    class_name: 'Prediction',
    foreign_key: 'random_pick_song_id'

  has_many :concert_songs
  has_many :concerts, through: :concert_songs
end
