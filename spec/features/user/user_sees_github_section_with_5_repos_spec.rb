require 'rails_helper'

describe "User visits the dashboard page", :vcr do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  it "doesn't display a section if a user lacks github token" do
    user = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content("Connect With GitHub")
    expect(page).to have_link("GitHub")
    expect(page).to_not have_content("GitHub Links")
    expect(page).to_not have_css(".github-repo-links")
  end

  it 'displays followers for logged in user', :vcr do
    repos = File.open("./spec/fixtures/repos.json")
    followers = File.open("./spec/fixtures/followers.json")
    following = File.open("./spec/fixtures/following.json")
    stub_request(:get, "https://api.github.com/user/repos").to_return({body: repos})
    stub_request(:get, "https://api.github.com/user/followers").to_return({body: followers})
    stub_request(:get, "https://api.github.com/user/following").to_return({body: following})

    user = create(:user, token: ENV["GITHUB_TOKEN_1"])

    visit "/login"

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on "Log In"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css(".github-repo-links")
    expect(page).to have_content("GitHub Links")
    expect(page).to have_content("Followers")
    expect(page).to have_content("Following")
    expect(page).to have_button("Log Out")
    expect(page).to_not have_button("Add Friend")
  end

  it 'allows user to add friend', :vcr do
    repos = File.open("./spec/fixtures/repos.json")
    followers = File.open("./spec/fixtures/followers.json")
    following = File.open("./spec/fixtures/following.json")
    stub_request(:get, "https://api.github.com/user/repos").to_return({body: repos})
    stub_request(:get, "https://api.github.com/user/followers").to_return({body: followers})
    stub_request(:get, "https://api.github.com/user/following").to_return({body: following})

    user_1 = create(:user, token: ENV["GITHUB_TOKEN_1"])
    user_2 = create(:user, uid: 39312419)

    visit "/login"
    fill_in 'session[email]', with: user_1.email
    fill_in 'session[password]', with: user_1.password
    click_on "Log In"

    expect(page).to have_button("Add Friend")

    first(:button, "Add Friend").click

    expect(page).to have_content("Friends")
    expect(page).to_not have_button("Add Friend")
    expect(page).to have_content(user_2.first_name)
  end
end
