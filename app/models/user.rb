# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_following, class_name: 'FollowingFollower',
                              foreign_key: 'follower_id',
                              inverse_of: :follower,
                              dependent: :destroy
  has_many :following, through: :active_following, source: :followed

  has_many :passive_following, class_name: 'FollowingFollower',
                               foreign_key: 'followed_id',
                               inverse_of: :followed,
                               dependent: :destroy
  has_many :followers, through: :passive_following, source: :follower

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_following.find_by(followed_id: other_user.id).destroy!
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
