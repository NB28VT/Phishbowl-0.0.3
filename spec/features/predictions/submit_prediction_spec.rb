require 'rails_helper'


feature "Enter prediction for a given show", %(
As a bored Phishhead waiting for Phish to go back on tour
I'd like to check my predictions against an upcoming show
So that I can practice my prediction skills
Acceptance criteria
[ ] A user can submit a prediction for an upcoming show
[ ] A user is given errors if they don't submit valid data
[ ] A user should be given a total of points based on their predictions


) do

  scenario "A user enter a valid prediction" do

    concert = FactoryGirl.create(:concert)
    visit dashboard_index_path
    click_link "Upcoming Shows"
    click_link concert.venue

    fill_in('Set One Opener', with: 'A Song I Heard the Ocean Sing')
    fill_in("Set One Closer", with: "Kill Devil Falls")
    fill_in("Set Two Opener", with: "Golden Age")
    fill_in("Set Two Closer", with: "Harry Hood")
    fill_in("Encore", with: "Sleeping Monkey")

    click_on "Submit Predictions"

    expect(page).to have_content "Predictions submitted!"
  end



end
