# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user)
  end

  test 'creating a new account' do
    user = FactoryBot.build(:user)
    visit new_user_registration_path
    fill_in 'Eメール',	with: user.email
    fill_in 'パスワード', with: user.password
    fill_in 'パスワード（確認用）', with: user.password_confirmation
    click_on 'アカウント登録'
    assert_text 'アカウント登録が完了しました。'
    assert_selector 'h1', text: '本'
  end

  test 'visiting users page' do
    sign_in_as(@user)
    visit users_path
    assert_selector 'h1', text: 'ユーザ'
    assert_selector 'td', text: @user.email
  end

  test 'editing own account' do
    sign_in_as(@user)
    visit users_path
    click_link '詳細', href: user_path(@user)
    assert_selector 'a', text: '編集'
    click_on '編集'
    fill_in 'Eメール', with: @user.email
    fill_in '現在のパスワード', with: @user.password
    click_on '更新'
    assert_text 'アカウント情報を変更しました。'
    click_on '戻る'
  end
end
