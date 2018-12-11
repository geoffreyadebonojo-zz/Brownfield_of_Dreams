class Friendship < ApplicationRecord

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :realism

  private

  def realism
    return unless user_id == friend_id
    errors.add :user, "Don't follow yourself"
  end

end
