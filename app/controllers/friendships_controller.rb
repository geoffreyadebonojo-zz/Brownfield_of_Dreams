class FriendshipsController < ApplicationController

  def create
    f = Friendship.new
    user = User.find(current_user.id)
    friend = User.where(uid: params[:format]).first
    f.user_id = user.id
    f.friend_id = friend.id
    f.save
    redirect_to dashboard_path
  end
end
