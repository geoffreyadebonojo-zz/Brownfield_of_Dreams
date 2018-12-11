class FriendshipsController < ApplicationController

  def create
    f = Friendship.new
    user = User.find(current_user.id)
    friend = User.where(uid: params[:format]).first
    f.user_id = user.id
    f.friend_id = friend.id
    f.save

    # e = Friendship.new
    # e.user_id = friend.id
    # e.friend_id = user.id
    # e.save
    redirect_to dashboard_path
  end

end