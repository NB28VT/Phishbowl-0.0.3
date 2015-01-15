require 'rails_helper'

RSpec.describe ShowLoader, :type => :model do
  it "loads a show into the database" do
    new_show = ShowLoader.new
    new_show.show_builder(
    "https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.recent"
    )

    expect(Concert.count).to eq(1)
  end

end
