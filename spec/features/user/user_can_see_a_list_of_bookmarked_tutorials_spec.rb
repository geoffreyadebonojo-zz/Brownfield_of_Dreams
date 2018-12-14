require 'rails_helper'

describe 'As a user', :vcr do
  it 'user can see bookmarked tutorials', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    tutorial = create(:tutorial)
    tutorial_2 = create(:tutorial)

    video_1 = create(:video, tutorial_id: tutorial.id, video_id: "J7ikFUlkP_k")
    video_2 = create(:video, tutorial_id: tutorial_2.id, position: 1, video_id: "J7ikFUlkP_k")
    video_3 = create(:video, tutorial_id: tutorial_2.id, position: 0, video_id: "J7ikFUlkP_k")

    user_video_1 = create(:user_video, user_id: user.id, video_id: video_1.id)
    user_video_2 = create(:user_video, user_id: user.id, video_id: video_2.id)

    visit '/dashboard'

    expect(page).to have_content(tutorial.title)
    expect(page).to have_content(video_1.title)

    expect(page).to have_content(tutorial_2.title)
    expect(page).to have_content(video_2.title)
  end
end
