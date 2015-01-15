require 'rails_helper'

feature "Enter prediction for a given show", %(
As a bored Phishhead waiting for Phish to go back on tour
I'd like to check my predictions against an upcoming show
So that I can practice my prediction skills
Acceptance criteria
[x] A user can submit a prediction for an upcoming show
[x] A user is given errors if they don't submit valid data
[ ] A user should be given a total of points based on their predictions


) do

  # scenario "A user can sign in and enter a valid prediction" do
  #   concert = FactoryGirl.create(:concert)
  #
  #   user = FactoryGirl.create(:user)
  #
  #   sign_in_as(user)
  #
  #   visit dashboard_index_path
  #   click_link "Upcoming Shows"
  #
  #   click_link concert.concert_date
  #   click_link "Make your predictions"
  #
  #   select('A Song I Heard the Ocean Sing', from: "Set One Opener")
  #   select("Kill Devil Falls", from: "Set One Closer")
  #   select("Golden Age", from: "Set Two Opener")
  #   select("Harry Hood", from: "Set Two Closer")
  #   select("Harry Hood", from: "Encore")
  #   select("Free", from: "Random Pick")
  #
  #   click_on "Submit Predictions"
  #
  #   expect(page).to have_content "Predictions submitted!"
  #   expect(page).to have_content "A Song I Heard the Ocean Sing"
  # end
  #
  # scenario "A user must be signed in to enter a prediction" do
  #   concert = FactoryGirl.create(:concert)
  #
  #   visit dashboard_index_path
  #   click_link "Upcoming Shows"
  #   click_link concert.concert_date
  #   click_link "Make your predictions"
  #
  #   expect(page).to have_content "You need to sign in or sign up before continuing"
  # end
  #

end
