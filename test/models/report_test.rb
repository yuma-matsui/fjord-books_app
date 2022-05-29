# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = FactoryBot.create(:report)
    @user = FactoryBot.create(:user)
  end

  test 'user should edit own report' do
    assert @report.editable?(@report.user)
  end

  test "user shouldn't edit other user's report" do
    assert_not @report.editable?(@user)
  end

  test 'should return short version time' do
    assert_equal @report.created_at.to_date, @report.created_on
  end

  test 'should count down Report when user is destroyed' do
    assert_difference 'Report.count', -1 do
      @report.user.destroy
    end
  end
end
