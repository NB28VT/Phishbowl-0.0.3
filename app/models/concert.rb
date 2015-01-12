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
    # setlist_data = jsoned[0]["setlistdata"]
    # setlist = Nokogiri::HTML(latest_setlist_data)
    #
    # set_one = []
    #
    # first_set_data = setlist.css('p')[0]
    #
    # first_set_data.css('a').each do |song|
    #   set_one << song.children.text
    # end
    #
    # set_two = []
    #
    # second_set_data = setlist.css('p')[1]
    #
    # second_set_data.css('a').each do |song|
    #   set_two << song.children.text
    # end
    #
    # encore = []
    #
    # encore_data = setlist.css('p')[2]
    #
    # encore_data.css('a').each do |song|
    #   encore << song.children.text
    # end

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
    Concert.create(
      concert_date: concert_data_hash[:concert_date],
      city: concert_data_hash[:city],
      state: concert_data_hash[:state],
      venue: concert_data_hash[:venue]
    )
  end
end
