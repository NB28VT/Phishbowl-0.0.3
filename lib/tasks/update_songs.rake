desc "Crawls the Phish.net song list and loads an updated table of songs with artist and gaps"

# don't drop everything

# FIND OR INITIALIZE BY,

# Song.find_or_initialize_by(:title, :artist)
# If doesn't findi initializes a new one
# song.update_attributes
# Put some puts in here "Saving #{song.title}"
# song.save!

# PUT IN SEED FILE
#

task :update_songs do
  Song.destroy_all
  Song.fill_song_table
end
