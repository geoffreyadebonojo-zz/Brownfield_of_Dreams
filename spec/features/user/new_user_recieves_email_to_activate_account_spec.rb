require 'rails_helper'

describe 'new user email activation' do
  it 'tells new user they have to activate their account' do
    visit '/'
    click_on "Register"
    expect(current_path).to eq(register_path)

    fill_in 'user[email]', with: "geoff@geoffcodes.com"
    fill_in 'user[first_name]', with: "Geoff"
    fill_in 'user[last_name]', with: "Adams"
    fill_in 'user[password]', with: "123"
    fill_in 'user[password_confirmation]', with: "123"
    click_on "Create Account"

    expect(current_path).to eq(dashboard_path)

    user = User.last
    expect(page).to have_content("Logged in as #{user.first_name}")
    expect(page).to have_content("This account has not yet been activated")
    expect(page).to_not have_content("Status: Active")
  end

  it 'shows activated user they are activated' do
    user = create(:user, activated: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    expect(page).to have_content("Logged in as #{user.first_name}")
    expect(page).to_not have_content("This account has not yet been activated")
    expect(page).to have_content("Status: Active")
  end
end
