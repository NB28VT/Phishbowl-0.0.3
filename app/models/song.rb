class Song < ActiveRecord::Base


  def self.fill_song_table

    load_song_page = HTTParty.get("http://phish.net/song/")
    parsed_song_page = Nokogiri::HTML(load_song_page)
    song_rows = parsed_song_page.css('tr')

    songs_hash = {}

    song_rows.each do |song|
      song_info = {}
      title = song.children.children[0].text
      artist = song.children.children[1].text
      if song.children.children[5]
        gap = song.children.children[5].text
      else
        gap = nil
      end

      song_info["artist"] = artist
      song_info["gap"] = gap
      
      songs_hash[title] = song_info
    end

end
