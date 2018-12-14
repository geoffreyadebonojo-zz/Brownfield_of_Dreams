require 'rails_helper'

describe 'A registered user', :vcr do
  it 'errors out if user doesnt have a github handle', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_on 'Send an Invite'

    expect(current_path).to eq(invite_path)

    fill_in 'Github Handle', with: 'dafjadf'

    click_on 'Send Invite'

    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end

  # it 'lets user send email to invite github user', :vcr do
  #   user = create(:user, username: "geoffreyadebonojo", token: "GITHUB_TOKEN_1", activated: false)
  #
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #   stub_request(:get, "https://api.github.com/user/iandouglas").with(headers: {"Authorization" => 'GITHUB_TOKEN_2' })
  #   .to_return(body: File.read("./spec/fixtures/invite_fixture.json"))
  #
  #   repos = File.open("./spec/fixtures/repos.json")
  #   followers = File.open("./spec/fixtures/followers.json")
  #   following = File.open("./spec/fixtures/following.json")
  #   stub_request(:get, "https://api.github.com/user/repos").to_return({body: repos})
  #   stub_request(:get, "https://api.github.com/user/followers").to_return({body: followers})
  #   stub_request(:get, "https://api.github.com/user/following").to_return({body: following})
  #
  #   visit '/invite'
  #
  #   expect(current_path).to eq(invite_path)
  #
  #   fill_in 'Github Handle', with:'nicklindeberg'
  #
  #   click_on 'Send Invite'
  #
  #   expect(page).to have_content("Successfully sent invite!")
  # end
end
