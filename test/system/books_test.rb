# frozen_string_literal: true

require 'application_system_test_case'
require 'helpers/sign_in_helper'

class BooksTest < ApplicationSystemTestCase
  include SignInHelper

  setup do
    @book = FactoryBot.create(:book)
    user = FactoryBot.create(:user)
    sign_in_as(user)
  end

  test 'visiting the index' do
    visit books_path
    assert_selector 'td', text: @book.title
  end

  test 'creating a Book' do
    visit books_path
    click_on '新規作成'

    fill_in 'メモ', with: @book.memo
    fill_in 'タイトル', with: @book.title
    click_on '登録する'

    assert_text '本が作成されました。'
    click_on '戻る'
  end

  test 'updating a Book' do
    visit books_path
    click_on '編集'

    fill_in 'タイトル', with: @book.title
    fill_in 'メモ', with: @book.memo
    click_on '更新する'

    assert_text '本が更新されました。'
    click_on '戻る'
  end

  test 'destroying a Book' do
    visit books_path
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '本が削除されました。'
  end
end
