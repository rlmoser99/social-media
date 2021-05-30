# frozen_string_literal: true

require "rails_helper"

RSpec.describe "notification for friendship request", type: :system do
  let!(:user) { create(:user) }
  let!(:friend) { create(:user, first_name: "Example", last_name: "Friend") }

  it "successfully shows count, notification, and resets" do
    sign_in(friend)
    visit(users_path)
    click_on("Add Friend")

    within(".friend-container") do
      expect(page).to have_css("input[value='Delete Request']")
    end

    sign_out(friend)
    user.reload
    sign_in(user)
    visit(root_path)

    within(".notification-count") do
      expect(page).to have_content(1)
    end

    visit(notifications_path)

    within(".friend-container") do
      expect(page).to have_content('Example Friend')
    end

    visit(users_path)

    expect(page).not_to have_selector(".notification-count")
  end
end
