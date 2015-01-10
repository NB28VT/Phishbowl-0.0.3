desc "Crawls the Phish.net song list and loads an updated table of songs with artist and gaps"

task :update_songs do
  Song.destroy_all
  Song.fill_song_table
end
