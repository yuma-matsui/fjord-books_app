# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = FactoryBot.create(:report)
    sign_in_as(@report.user)
  end

  test 'visiting reports page' do
    visit reports_path
    assert_selector 'h1', text: '日報'
    assert_selector 'td', text: @report.title
  end

  test 'creating a report' do
    visit reports_path
    assert has_link? '新規作成', href: new_report_path
    click_on '新規作成'
    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_on '登録する'
    assert_text '日報が作成されました。'
    assert_selector 'p', text: @report.title
  end

  test 'editing a report' do
    visit reports_path
    assert has_link? '詳細', href: report_path(@report)
    click_link '詳細', href: report_path(@report)
    assert has_link? '編集', href: edit_report_path(@report)
    click_on '編集'
    fill_in 'タイトル', with: @report.title
    fill_in '内容',    with: @report.content
    click_on '更新する'
    assert_text '日報が更新されました。'
  end

  test 'destroying a report' do
    visit reports_path
    assert has_link? '削除', href: report_path(@report)
    page.accept_confirm do
      click_on '削除', match: :first
    end
    assert_text '日報が削除されました。'
    assert_no_selector 'td', text: @report.title
  end
end
