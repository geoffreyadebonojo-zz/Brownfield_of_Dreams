class User < ApplicationRecord

  has_many :friendships
  has_many :friendships, foreign_key: :friend_id, class_name: 'Friendship'
  has_many :friends, through: :friendships
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def from_omniauth(auth)
    self.uid = auth["uid"]
    self.provider = auth.provider
    self.token = auth["credentials"]["token"]
    self.save
  end

  def bookmarks
    self.videos.joins(:tutorial).
    select('videos.title, videos.position, tutorials.title AS tutorial_title')
    .order('tutorial_title, position')
  end
end
