require 'rails_helper'

describe 'On the home Page' do
  context 'as a visitor' do
    it 'shows non classroom tutorials' do
      tutorial_1 = create(:tutorial, classroom: true)
      tutorial_2 = create(:tutorial)

      visit '/'

      expect(page).to_not have_content(tutorial_1.title)
      expect(page).to have_content(tutorial_2.title)
    end
  end

  context 'as a user' do
    it 'shows all tutorials' do
      user = create(:user)
      visit '/login'

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      click_on 'Log In'

      tutorial_1 = create(:tutorial, classroom: true, title: 'show up')
      tutorial_2 = create(:tutorial)

      visit '/'

      expect(page).to have_content(tutorial_1.title)
      expect(page).to have_content(tutorial_2.title)
    end
  end
end
