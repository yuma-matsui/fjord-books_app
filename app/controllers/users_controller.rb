# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: %i[show following followers]
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show; end

  def following
    @users = @user.following.page(params[:page])
  end

  def followers
    @users = @user.followers.page(params[:page])
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
