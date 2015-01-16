class SongLoader

  def load_song_table
    # NEED EXCEPTION HANDLING HERE

    load_song_page = HTTParty.get("http://phish.net/song/")
    parsed_song_page = Nokogiri::HTML(load_song_page)
    song_rows = parsed_song_page.css('tr')

    songs_hash = {}

    # Accounts for songs with trunacated names on scraped web page
    truncated_song_hash = {
      "Big Black Furry Creature from ..." => "Big Black Furry Creature from Mars",
      "Come On Baby, Let's Go Downtow..." => "Come On Baby, Let's Go Downtown",
      "Long Cool Woman in a Black Dre..." =>"Long Cool Woman in a Black Dress",
      "McGrupp and the Watchful Hosem..." => "McGrupp and the Watchful Hosemasters",
      "My Mind's Got a Mind of its Ow..." => "My Mind's Got a Mind of its Own",
      "Stealing Time From the Faulty ..." => "Stealing Time From the Faulty Plan",
      "The Man Who Stepped Into Yeste..." => "The Man Who Stepped Into Yesterday",
      "Sneakin' Sally Through the All..." => "Sneakin' Sally Through the Alley"
    }

    song_rows.each do |song|
      if song.children.children[2].text != "1"
        song_info = {}
        title = song.children.children[0].text
        artist = song.children.children[1].text
        if song.children.children[5]
          gap = song.children.children[5].text
        else
          gap = nil
        end

        if truncated_song_hash.has_key?(title)
          title = truncated_song_hash[title]
        end

        song_info["artist"] = artist
        song_info["gap"] = gap

        songs_hash[title] = song_info
      end
    end
    # removes first row (column header)
    songs_hash.delete("Song Name")
    songs_hash
  end
end
