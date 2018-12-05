require 'rails_helper'

describe "User visits the dashboard page" do

  it "sees links to github repos" do

    stub_request(:get, "https://api.github.com/user/repos").to_return(body: File.read("./spec/fixtures/user_data.json"))

    user = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    # TODO CREATE REPOS

    visit '/dashboard'

    within('.github-title') do
      expect(page).to have_content("GitHub Links")
    end

    expect(page).to have_css(".github-repo-links", count: 5)

    # VCR.use_cassette("features/user_sees_github_section_with_5_repos") do

    # binding.pry
    expect(page).to have "2win_playlist"

    expect(current_path).to eq("/geoffreyadebonojo/2win_playlist")

    # end
  end
end
