require 'rails_helper'


feature "Add a random show", %(
As a Phishead
I'd like to add an upcoming show
So that I can practice my prediction skills agains that show
Acceptance criteria
[ ] A user can load a random show onto the show page
[ ] A user can vist the prediction page for that show


) do


  scenario "A user can load a random show onto the show page" do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    visit dashboard_index_path
    click_link "Upcoming Shows"
    click_link "Add a new random show"

    expect(page).to have_content "Show added"
  end





end
