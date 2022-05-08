# frozen_string_literal: true

class FollowingFollowersController < ApplicationController
  after_action :return_ajax, only: %i[create destroy]

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end

  def destroy
    @user = FollowingFollower.find(params[:id]).followed
    current_user.unfollow(@user)
  end

  private

  def return_ajax
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
