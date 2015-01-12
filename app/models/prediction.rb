class Prediction < ActiveRecord::Base
  belongs_to :concert,  class_name: "Concert", foreign_key: "concert_id"
  belongs_to :user

  belongs_to :set_one_opener_song, class_name: "Song", foreign_key: "set_one_opener_song_id"
  belongs_to :set_one_closer_song, class_name: "Song", foreign_key: "set_one_closer_song_id"
  belongs_to :set_two_opener_song, class_name: "Song", foreign_key: "set_two_opener_song_id"
  belongs_to :set_two_closer_song, class_name: "Song", foreign_key: "set_two_closer_song_id"
  belongs_to :encore_song, class_name: "Song", foreign_key: "encore_song_id"
  belongs_to :random_pick_song, class_name: "Song", foreign_key: "random_pick_song_id"

  validates_presence_of :set_one_opener_song_id
  validates_presence_of :set_one_closer_song_id
  validates_presence_of :set_two_opener_song_id
  validates_presence_of :set_two_closer_song_id
  validates_presence_of :encore_song_id
  validates_presence_of :random_pick_song_id



  Dotenv.load
  # api_key = ENV[names of keys]


  def load_latest_show
    latest_setlist = HTTParty.get("https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.latest")

    jsoned = JSON.parse(latest_setlist)
    latest_setlist_data = jsoned[0]["setlistdata"]
    setlist = Nokogiri::HTML(latest_setlist_data)

    set_one = []

    first_set_data = setlist.css('p')[0]

    first_set_data.css('a').each do |song|
      set_one << song.children.text
    end

    set_two = []

    second_set_data = setlist.css('p')[1]

    second_set_data.css('a').each do |song|
      set_two << song.children.text
    end

    encore = []

    encore_data = setlist.css('p')[2]

    encore_data.css('a').each do |song|
      encore << song.children.text
    end
  end

  # Loads a list of all Phish songs and covers from Phish.net, into hash
  def self.load_songs_and_gaps

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

    # removes first row (column header)

    songs_hash.delete("Song Name")
    songs_hash
  end

  def self.load_cover_songs(song_hash)
    cover_songs = []
    song_hash.each do |song|
      if song[1]["artist"] != "Phish"
        cover_songs << song[0]
      end
    end
    cover_songs
  end

  #Returns a hash of songs with artist and gap as values
  @songs_hash = load_songs_and_gaps

  # Shouldn't need this, but keep just in case

  # [
  #   :set_one_opener,
  #   :set_one_closer,
  #   :set_two_opener,
  #   :set_two_closer,
  #   :encore,
  # ].each do |n|
  #   validates n, inclusion: { in: @songs_hash.keys, message: "Picks must be a song Phish has played."}
  # end

end
