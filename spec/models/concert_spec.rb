require 'rails_helper'

RSpec.describe Concert, :type => :model do

  it "loads a random show into the database" do
    random_show = Concert.create_random_show
    expect(random_show.save).to eq(true)
  end

end
