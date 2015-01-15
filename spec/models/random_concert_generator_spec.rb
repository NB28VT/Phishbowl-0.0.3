require 'rails_helper'

RSpec.describe RandomConcertGenerator, :type => :model do
  it "loads a random show into the database" do
    new_concert = RandomConcertGenerator.new
    new_concert.generate_random_concert

    expect(Concert.count).to eq(1)
  end
end
