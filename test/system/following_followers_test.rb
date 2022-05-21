# frozen_string_literal: true

require 'application_system_test_case'

class FollowingFollowersTest < ApplicationSystemTestCase
  include SignInHelper

  setup do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    sign_in_as(@user)
  end

  test 'following a user' do
    visit users_path
    click_link '詳細', href: user_path(@other_user)
    assert has_button?('フォローする')
    click_on 'フォローする'
    assert_text 'フォローしました。'
    assert has_button?('フォロー解除する')
  end

  test 'unfollowing a user' do
    @user.follow(@other_user)
    visit users_path
    click_link '詳細', href: user_path(@other_user)
    assert has_button?('フォロー解除する')
    click_on 'フォロー解除する'
    assert_text 'フォロー解除しました。'
    assert has_button?('フォローする')
  end
end
