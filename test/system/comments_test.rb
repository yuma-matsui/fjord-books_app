# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    @book_comment = FactoryBot.create(:comment, :for_book)
    @report_comment = FactoryBot.create(:comment, :for_report)
    @user = FactoryBot.create(:user)
    sign_in_as(@user)
  end

  test 'should exist a comment on a book page' do
    visit books_path
    click_link '詳細', href: book_path(@book_comment.commentable)
    assert_selector 'li', text: @book_comment.content
  end

  test 'should exist a comment on a report page' do
    visit reports_path
    click_link '詳細', href: report_path(@report_comment.commentable)
    assert_selector 'li', text: @report_comment.content
  end

  test 'creating a comment on a book page' do
    visit books_path
    click_link '詳細', href: book_path(@book_comment.commentable)
    assert has_button? 'コメントする'
    fill_in with: @book_comment.content, id: 'comment_content'
    click_on 'コメントする'
    assert_text 'コメントが投稿されました。'
    assert_selector 'li', text: @book_comment.content
  end

  test 'creating a comment on a report page' do
    visit reports_path
    click_link '詳細', href: report_path(@report_comment.commentable)
    assert has_button? 'コメントする'
    fill_in with: @report_comment.content, id: 'comment_content'
    click_on 'コメントする'
    assert_text 'コメントが投稿されました。'
    assert_selector 'li', text: @report_comment.content
  end
end
