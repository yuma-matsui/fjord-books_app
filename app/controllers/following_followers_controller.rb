# frozen_string_literal: true

class FollowingFollowersController < ApplicationController
  before_action :find_following_follower, only: %i[destroy]

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    user = @following_follower.followed
    @following_follower.destroy!
    redirect_to user
  end

  private

  def find_following_follower
    @following_follower = FollowingFollower.find(params[:id])
  end
end
