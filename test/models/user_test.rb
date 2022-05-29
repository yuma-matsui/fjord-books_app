# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end

  test 'should count up Relationship when user follows some user' do
    assert_difference 'Relationship.count', 1 do
      @user.follow(@other_user)
    end
  end

  test 'should count down Relationship when user unfollows some user' do
    @user.follow(@other_user)
    assert_difference 'Relationship.count', -1 do
      @user.unfollow(@other_user)
    end
  end

  test 'should return true when user is following other user' do
    @user.follow(@other_user)
    assert @user.following?(@other_user)
  end

  test 'should return true when user is followed by other user' do
    @user.follow(@other_user)
    assert @other_user.followed_by?(@user)
  end

  test 'should return name when user has name' do
    assert_equal @user.name, @user.name_or_email
  end

  test "should return email when user doesn't have name" do
    @user.name = ''
    assert_equal @user.email, @user.name_or_email
  end

  test 'should count down Relathionship when user is destroyed' do
    @user.follow(@other_user)
    assert_difference 'Relationship.count', -1 do
      @user.destroy
    end
  end

  test 'sould includes other user in followings when user is following other user' do
    @user.follow(@other_user)
    assert @user.followings.include?(@other_user)
  end

  test 'sould includes user in followers when other user is followed by user' do
    @user.follow(@other_user)
    assert @other_user.followers.include?(@user)
  end
end
