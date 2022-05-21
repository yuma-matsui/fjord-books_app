# frozen_string_literal: true

module SignInHelper
  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'Eメール',	 with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'ログイン'
  end
end
