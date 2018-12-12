class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :non_self
  validates_presence_of :friend_id

  private

  def non_self
    return unless user_id == friend_id
  end
end
