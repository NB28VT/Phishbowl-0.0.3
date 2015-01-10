require 'rails_helper'


feature "Prediction on random show", %(
As a Phishead
I'd like to guess a setlist for a random show
So that I can practice my prediction skills agains that show
Acceptance criteria
[ ] The app can load a random show onto the show page
[ ] A user can vist the prediction page for that show


) do


  scenario "The app loads a random show onto the show page" do
    # TESTS START WITH EXISTING CONCERT WHAT WHERE IS THIS COMING FROM???
    user = FactoryGirl.create(:user)
    concert = FactoryGirl.create(:concert)
    # ALSO THIS IS PULLING THE SAME SHOW AS THE ONE ABOVE

    sign_in_as(user)

    visit dashboard_index_path
    click_link "Upcoming Shows"

    expect(page).to have_content (concert.concert_date)
    concert.destroy!
  end
end
