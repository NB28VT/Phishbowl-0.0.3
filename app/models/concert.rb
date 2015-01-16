class Concert < ActiveRecord::Base
  has_many :predictions
  has_many :concert_songs
  has_many :songs,
    through: :concert_songs

  validates :concert_date, uniqueness: true

  Dotenv.load

  # show loader class, intherit into specific calls

  # store in app models

  def self.load_latest_show
    show_loader(
    "https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.latest"
    )
  end
end
