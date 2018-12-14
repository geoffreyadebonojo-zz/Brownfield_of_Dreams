# require 'rails_helper'

# describe 'admin can create new video' do
#   let(:tutorial) { create(:tutorial) }
#   let(:admin)    { create(:admin) }

#   it 'must have position' do
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

#     visit edit_admin_tutorial_path(tutorial)

#     click_on "Add Video"

#     fill_in "video[title]", with: "How to tie your shoes."
#     fill_in "video[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
#     fill_in "video[video_id]", with: "J7ikFUlkP_k"
#     click_on "Create Video"

#     expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

#     expect(page).to have_content("Unable to create video")
#   end
# end
