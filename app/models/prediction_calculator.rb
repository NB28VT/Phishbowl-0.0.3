class PredictionCalculator

  # CLASS PREDICTION TIME CALCULATOR

  # findby, use associations YOU HAVE THIS DATA
  # DONT FIX YOUR CODE TO ACCOUNT FOR BAD DATA, FIX YOUR BAD DATA

  def pick_checker(play_index, set_index, prediction_song)


    # USE THE ASSOCIATIONS LUKE!!!


    song = Song.find_by(
    id:(@actual_setlist.find_by(play_index: play_index, set_index: set_index).song_id))

    if prediction_song == song
      @prediction_score += 3
    elsif @actual_setlist.include?(prediction_song)
      @prediction_score += 1
    end
  end

  def random_pick_checker
  end



  # def check_set_one_opener
  #   actual_set_one_opener = Song.find_by(
  #   id:(@actual_setlist.find_by(play_index: 1, set_index: 1).song_id))
  #
  #   if self.set_one_opener_song == actual_set_one_opener
  #     @prediction_score += 3
  #   elsif @actual_setlist.include?(self.set_one_opener_song)
  #     @prediction_score += 1
  #   end
  # end
  #
  # def check_set_one_closer
  #   songs_in_first_set = (self.concert.concert_songs.where(set_index: 1).first).songs_in_set
  #
  #   actual_set_one_closer = Song.find_by(
  #   id:(@actual_setlist.find_by(play_index: songs_in_first_set, set_index:
  #   1).song_id))
  #
  #   if self.set_one_closer_song == actual_set_one_closer
  #     @prediction_score += 3
  #   elsif @actual_setlist.include?(self.set_one_closer_song)
  #     @prediction_score += 1
  #   end
  # end
  #
  # def check_set_two_opener
  #   actual_set_two_opener = Song.find_by(
  #   id:(@actual_setlist.find_by(play_index: 1, set_index: 2).song_id))
  #
  #   if self.set_two_opener_song == actual_set_two_opener
  #     @prediction_score += 3
  #   elsif @actual_setlist.include?(self.set_two_opener_song)
  #     @prediction_score += 1
  #   end
  # end
  #
  # def check_set_two_closer
  #   songs_in_second_set = (self.concert.concert_songs.where(set_index: 2).first).songs_in_set
  #
  #   actual_set_two_closer = Song.find_by(
  #   id:(@actual_setlist.find_by(play_index: songs_in_second_set, set_index:
  #   2).song_id))
  #
  #   if self.set_two_closer_song == actual_set_two_closer
  #     @prediction_score += 3
  #   elsif @actual_setlist.include?(self.set_one_closer_song)
  #     @prediction_score += 1
  #   end
  # end

  def check_encore(song)
    if Song.find_by(
      id:(@actual_setlist.find_by(play_index: 1, set_index: 3)))
      pick_checker(1, 3, song)
    end
  end

  def check_random_pick(prediction)
    if @actual_setlist.any?{ |song_id| song_id = prediction.random_pick_song.id }
      @prediction_score += 2
    end
  end


  def songs_in_first_set
    (@actual_setlist.where(set_index: 1).first).songs_in_set
  end

  def songs_in_second_set
    (@actual_setlist.where(set_index: 2).first).songs_in_set
  end


  def get_prediction_score(prediction)
    @actual_setlist = prediction.concert.concert_songs
    @prediction_score = 0

    pick_checker(1, 1, prediction.set_one_opener_song)
    pick_checker(songs_in_first_set, 1, prediction.set_one_closer_song)
    pick_checker(1, 2, prediction.set_two_opener_song)
    pick_checker(songs_in_second_set, 2, prediction.set_two_closer_song)
    check_encore(prediction.encore_song)
    check_random_pick(prediction)

    @prediction_score
  end

end
