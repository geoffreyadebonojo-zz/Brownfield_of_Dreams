require 'rails_helper'

describe "User visits the dashboard page" do

  it "sees links to github repos" do

    user = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    # TODO CREATE REPOS

    visit '/dashboard'

    within('.github-title') do
      expect(page).to have_content("GitHub Links")
    end

    expect(page).to have_css(".github-repo-links", count: 5)

    expect(page).to have_content("2win_playlist")

  end

  it "doesn't display a section if a user lacks github token" do 
    user = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


  end
end
