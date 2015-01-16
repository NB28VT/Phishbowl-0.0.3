require 'rails_helper'


feature "Prediction on random show", %(
As a Phishead
I'd like to guess a setlist for a random show
So that I can practice my prediction skills agains that show
Acceptance criteria
[ ] The app can load a random show onto the show page
[ ] A user can vist the prediction page for that show


) do


  scenario "A user can check predictions against a random show" do

    user = FactoryGirl.create(:user)

    sign_in_as(user)

    visit dashboard_index_path

    click_link "Play with random concert"

    click_link "Play Phantasy Phishbowl!"

    select('A Song I Heard the Ocean Sing', from: "Set One Opener")
    select("Kill Devil Falls", from: "Set One Closer")
    select("Golden Age", from: "Set Two Opener")
    select("Harry Hood", from: "Set Two Closer")
    select("Harry Hood", from: "Encore")
    select("Free", from: "Random Pick")

    click_on "Submit Predictions"

    click_on "Check Score"

    expect(page).to have_content ("Your score is...")
  end


  scenario "A user can edit predictions for a random show" do





  end
end
