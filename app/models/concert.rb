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

    encore = []

    # breaks if no encore. IF THERE IS AN ENCORE? Still doesn't work

    encore_data = setlist.css('p')[2]

    encore_data.css('a').each do |song|
      encore << song.children.text
    end

    concert_data_hash[:encore_array] = encore

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
    # IF CONCERT EXISTS KEEP TRYING




  end

  def self.create_random_show
    concert_data_hash = load_random_show

    new_concert = Concert.create(
      concert_date: concert_data_hash[:concert_date],
      city: concert_data_hash[:city],
      state: concert_data_hash[:state],
      venue: concert_data_hash[:venue]
    )
    # BUILDING METHOD FOR CONCERT SONGS
    # SET ONE
    concert_data_hash[:set_one_array].each do |song|
      binding.pry
      index = 0
      ConcertSong.create(
      # UGLY
        song_id: Song.find_by(song_name: song).id,
        play_index: index,
        set_index: 1,
        concert_id: new_concert.id
      )
      index += 1
    end

    concert_data_hash[:set_two_array].each do |song|
      index = 0
      ConcertSong.create(
      # UGLY
      song_id: Song.find_by(song_name: song).id,
      play_index: index,
      set_index: 2,
      concert_id: new_concert.id
      )
      index += 1
    end

    concert_data_hash[:encore_array].each do |song|
      index = 0
      ConcertSong.create(
      # UGLY
      song_id: Song.find_by(song_name: song).id,
      play_index: index,
      set_index: 3,
      concert_id: new_concert.id
      )
      index += 1
    end


    # PASS RANDOM SHOW AS OBJECT HERE?
    # new_concert
  end
end
