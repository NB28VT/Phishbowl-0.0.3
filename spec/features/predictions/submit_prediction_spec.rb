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


  scenario "A user can sign in and enter a valid prediction" do
    concert = FactoryGirl.create(:concert)

    user = FactoryGirl.create(:user)

    sign_in_as(user)

    visit dashboard_index_path
    click_link "Upcoming Shows"

    click_link concert.concert_date
    click_link "Make your predictions"

    # NOT SURE IF THIS WILL WORK..

    select("A Song I Heard the Ocean Sing", from: "Set One Opener")
    select("Kill Devil Falls", from: "Set One Closer")
    select("Golden Age", from: "Set Two Opener")
    select("Harry Hood", from: "Set Two Closer")
    select("Free", from: "Random Pick")

    # fill_in('Set One Opener', with: 'A Song I Heard the Ocean Sing')
    # fill_in("Set One Closer", with: "Kill Devil Falls")
    # fill_in("Set Two Opener", with: "Golden Age")
    # fill_in("Set Two Closer", with: "Harry Hood")
    # fill_in("Encore", with: "Sleeping Monkey")
    # fill_in("Random Pick", with: "Free")

    click_on "Submit Predictions"

    expect(page).to have_content "Predictions submitted!"
    expect(page).to have_content "A Song I heard the Ocean Sing"
    concert.destroy!
  end

  scenario "A user must be signed in to enter a prediction" do
    concert = FactoryGirl.create(:concert)

    visit dashboard_index_path
    click_link "Upcoming Shows"
    click_link concert.concert_date
    click_link "Make your predictions"

    expect(page).to have_content "You need to sign in or sign up before continuing"
    concert.destroy!
  end
end
