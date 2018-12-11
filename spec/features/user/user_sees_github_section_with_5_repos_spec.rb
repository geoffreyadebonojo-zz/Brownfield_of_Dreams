require 'rails_helper'

describe "User visits the dashboard page" do
  it "doesn't display a section if a user lacks github token" do
    user = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_content("GitHub Links")
    expect(page).to_not have_css(".github-repo-links", count: 5)
  end
end
