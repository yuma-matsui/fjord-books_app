# frozen_string_literal: true

module ApplicationHelper
  def allowed_user?(user)
    current_user == user
  end

  def show_name_or_email(user)
    user.name.blank? ? user.email : user.name
  end
end
