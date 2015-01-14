class Concert < ActiveRecord::Base
  has_many :predictions
  validates :concert_date, uniqueness: true

  Dotenv.load

  def self.show_loader(api_call)
    concert = HTTParty.get(api_call)

    jsoned = JSON.parse(concert)

    concert_data_hash = {}

    concert_data_hash[:concert_date] = jsoned[0]["mmddyy"]
    concert_data_hash[:city] = jsoned[0]["city"]
    concert_data_hash[:state] = jsoned[0]["state"]
    concert_data_hash[:venue] = jsoned[0]["venue"]

    setlist_data = jsoned[0]["setlistdata"]
    setlist = Nokogiri::HTML(setlist_data)

    set_one = []

    first_set_data = setlist.css('p')[0]

    first_set_data.css('a').each do |song|
      set_one << song.children.text
    end

    concert_data_hash[:set_one_array] = set_one

    set_two = []

    second_set_data = setlist.css('p')[1]

    second_set_data.css('a').each do |song|
      set_two << song.children.text
    end

    concert_data_hash[:set_two_array] = set_two


    # breaks if no encore. IF THERE IS AN ENCORE? Still doesn't work

    if setlist.css('p')[2]

      encore = []

      encore_data = setlist.css('p')[2]

      encore_data.css('a').each do |song|
        encore << song.children.text
      end
      concert_data_hash[:encore_array] = encore
    else
      concert_data_hash[:encore_array] = nil
    end

    concert_data_hash
  end

  def self.load_latest_show
    show_loader(
    "https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.latest"
    )
  end

  def self.load_random_show
    show_loader(
    "https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.random"
    )
  end

  def self.create_random_show
    concert_data_hash = load_random_show

    new_concert = Concert.find_or_initialize_by(
      concert_date: concert_data_hash[:concert_date],
      city: concert_data_hash[:city],
      state: concert_data_hash[:state],
      venue: concert_data_hash[:venue]
    )

    new_concert.save

    # find or initialize by on song id?

    # DRY UP THIS CODE AFTER WORKS

    # CODE WORKS. NEED TO HANDLE NIL SETS!!!!

    song_index = 1
    concert_data_hash[:set_one_array].each do |song|
      new_song = ConcertSong.find_or_initialize_by(
        song_id: Song.find_by(song_name: song).id,
        play_index: song_index,
        set_index: 1,
        concert_id: new_concert.id,
        songs_in_set: concert_data_hash[:set_one_array].count
      )
      song_index += 1
      new_song.save
    end

    song_index = 1
    concert_data_hash[:set_two_array].each do |song|
      new_song = ConcertSong.find_or_initialize_by(
      song_id: Song.find_by(song_name: song).id,
      play_index: song_index,
      set_index: 2,
      concert_id: new_concert.id,
      songs_in_set: concert_data_hash[:set_two_array].count
      )
      song_index += 1
      new_song.save
    end

    # if encore array is empty

    if concert_data_hash[:encore_array].count > 0
      song_index = 1
      concert_data_hash[:encore_array].each do |song|
        new_song = ConcertSong.find_or_initialize_by(
        song_id: Song.find_by(song_name: song).id,
        play_index: song_index,
        set_index: 3,
        concert_id: new_concert.id,
        songs_in_set: concert_data_hash[:encore_array].count
        )
        song_index += 1
        new_song.save
      end
    end
  end
end
