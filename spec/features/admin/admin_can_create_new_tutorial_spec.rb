require 'rails_helper'

describe 'admin can create new tutorial' do
  let(:admin)    { create(:admin) }
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit new_admin_tutorial_path
    end

  it 'creates new tutorial and displays on tutorials page' do
    fill_in "tutorial[title]", with: "How to own a cat"
    fill_in "tutorial[description]", with: "Teaches you how to server you cat"
    fill_in "tutorial[thumbnail]", with: "https://media.tenor.com/images/47b81948be5023555549c01d88ae3289/tenor.gif"
    click_on "Save"
    tutorial = Tutorial.last

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content(tutorial.title)
  end

  it 'will not let admin create tutorial if missing description' do
    fill_in "tutorial[title]", with: "How to own a cat"
    fill_in "tutorial[thumbnail]", with: "https://media.tenor.com/images/47b81948be5023555549c01d88ae3289/tenor.gif"
    click_on "Save"

    expect(current_path).to eq(new_admin_tutorial_path)
  end

  it 'will not let admin create tutorial if missing thumbnail' do
    fill_in "tutorial[title]", with: "How to own a cat"
    fill_in "tutorial[description]", with: "Teaches you how to server you cat"
    click_on "Save"

    expect(current_path).to eq(new_admin_tutorial_path)
  end

  it 'will not let admin create tutorial if missing title' do
    fill_in "tutorial[description]", with: "Teaches you how to server you cat"
    fill_in "tutorial[thumbnail]", with: "https://media.tenor.com/images/47b81948be5023555549c01d88ae3289/tenor.gif"
    click_on "Save"

    expect(current_path).to eq(new_admin_tutorial_path)
  end

  xit 'tutorial can be deleted ' do
    fill_in "tutorial[title]", with: "How to own a cat"
    fill_in "tutorial[description]", with: "Teaches you how to server you cat"
    fill_in "tutorial[thumbnail]", with: "https://media.tenor.com/images/47b81948be5023555549c01d88ae3289/tenor.gif"

    click_on "Save"
    tutorial = Tutorial.last
    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content(tutorial.title)
    save_and_open_page
    click_on "Destroy"
  end
end
