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

  # CLASS PREDICTION TIME CALCULATOR

  # findby, use associations YOU HAVE THIS DATA
  # DONT FIX YOUR CODE TO ACCOUNT FOR BAD DATA, FIX YOUR BAD DATA
  def check_set_one_opener
    actual_set_one_opener = Song.find_by(
      id:(@actual_setlist.find_by(play_index: 1, set_index: 1).song_id))

    if self.set_one_opener_song == actual_set_one_opener
      @prediction_score += 3
    elsif @actual_setlist.include?(self.set_one_opener_song)
      @prediction_score += 1
    end
  end

  def check_set_one_closer
    songs_in_first_set = (self.concert.concert_songs.where(set_index: 1).first).songs_in_set

    actual_set_one_closer = Song.find_by(
      id:(@actual_setlist.find_by(play_index: songs_in_first_set, set_index:
      1).song_id))

    if self.set_one_closer_song == actual_set_one_closer
      @prediction_score += 3
    elsif @actual_setlist.include?(self.set_one_closer_song)
      @prediction_score += 1
    end
  end

  def check_set_two_opener
    actual_set_two_opener = Song.find_by(
    id:(@actual_setlist.find_by(play_index: 1, set_index: 2).song_id))

    if self.set_two_opener_song == actual_set_two_opener
      @prediction_score += 3
    elsif @actual_setlist.include?(self.set_two_opener_song)
      @prediction_score += 1
    end
  end

  def check_set_two_closer
    songs_in_second_set = (self.concert.concert_songs.where(set_index: 2).first).songs_in_set

    actual_set_two_closer = Song.find_by(
    id:(@actual_setlist.find_by(play_index: songs_in_second_set, set_index:
    2).song_id))

    if self.set_two_closer_song == actual_set_two_closer
      @prediction_score += 3
    elsif @actual_setlist.include?(self.set_one_closer_song)
      @prediction_score += 1
    end
  end

  def check_encore
    if Song.find_by(
      id:(@actual_setlist.find_by(play_index: 1, set_index: 3)))

      actual_encore = Song.find_by(
      id:(@actual_setlist.find_by(play_index: 1, set_index: 3).song_id))

      if self.encore_song == actual_encore
        @prediction_score += 3
      elsif @actual_setlist.include?(self.encore_song)
        @prediction_score += 1
      end
    end
  end

  def check_random_pick

    if @actual_setlist.any?{ |song_id| song_id = self.random_pick_song.id }
      @prediction_score += 2
    end
  end

  def get_prediction_score
    @actual_setlist = self.concert.concert_songs
    @prediction_score = 0

    check_set_one_opener
    check_set_one_closer
    check_set_two_opener
    check_set_two_closer
    check_encore
    check_random_pick

    @prediction_score
  end
end
