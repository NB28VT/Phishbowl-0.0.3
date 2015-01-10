# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




# desc "Crawls the Phish.net song list and loads an updated table of songs with artist and gaps"

# don't drop everything

# FIND OR INITIALIZE BY,

# Song.find_or_initialize_by(:title, :artist)
# If doesn't findi initializes a new one
# song.update_attributes
# Put some puts in here "Saving #{song.title}"
# song.save!

# PUT IN SEED FILE
#



# switch song to title
song_hash = Song.load_song_table

song_hash.each do |song_data|
  song = Song.find_or_initialize_by(song_name: song_data[0])
  song.artist_name = song_data[1]["artist"]
  song.song_gap = song_data[1]["gap"]
  song.song_name = song_data[0]
  song.save!
end
