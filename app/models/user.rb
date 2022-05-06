# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_following, class_name: 'FollowingFollower',
                              foreign_key: 'follower_id',
                              dependent: :destroy
  has_many :following, through: :active_following, source: :followed

  has_many :passive_following, class_name: 'FollowingFollower',
                               foreign_key: 'followed_id',
                               dependent: :destroy
  has_many :followers, through: :passive_following, source: :follower
end
