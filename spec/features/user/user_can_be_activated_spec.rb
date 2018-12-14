require 'rails_helper'

describe "user" do 
  it "can be updated to activated" do 
    user = create(:user, activated: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/activated'

    expect(user.activated).to eq(true)
  end
end