require 'rails_helper'

RSpec.describe ConcertLoader, :type => :model do
  it "loads a recent show into the database" do
    new_concert = ConcertLoader.new
    new_concert.concert_builder(
      "https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.recent"
    )

    expect(Concert.count).to eq(1)
  end

end
