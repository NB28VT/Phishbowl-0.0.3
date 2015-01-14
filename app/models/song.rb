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

  def self.load_song_table

    load_song_page = HTTParty.get("http://phish.net/song/")
    parsed_song_page = Nokogiri::HTML(load_song_page)
    song_rows = parsed_song_page.css('tr')

    songs_hash = {}

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

        if title == "Big Black Furry Creature from ..."
          title = "Big Black Furry Creature from Mars"
        elsif title == "Come On Baby, Let's Go Downtow..."
          title = "Come On Baby, Let's Go Downtown"
        elsif title == "Long Cool Woman in a Black Dre..."
          title = "Long Cool Woman in a Black Dress"
        elsif title == "McGrupp and the Watchful Hosem..."
          title = "McGrupp and the Watchful Hosemasters"
        elsif title == "My Mind's Got a Mind of its Ow..."
          title = "My Mind's Got a Mind of its Own"
        elsif title == "Stealing Time From the Faulty ..."
          title = "Stealing Time From the Faulty Plan"
        elsif title == "The Man Who Stepped Into Yeste..."
          title = "The Man Who Stepped Into Yesterday"
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
