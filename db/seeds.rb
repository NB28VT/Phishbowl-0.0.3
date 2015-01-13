# switch song to title?
# IS THIS ACTUALLY UPDATING IF THE RECORD EXISTS?
song_hash = Song.load_song_table


song_hash.each do |song_data|
  song = Song.find_or_initialize_by(song_name: song_data[0])
  song.artist_name = song_data[1]["artist"]
  song.song_gap = song_data[1]["gap"]
  song.song_name = song_data[0]
  song.save!
end
