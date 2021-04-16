# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user recieves a notification from friend request", type: :system do
  let!(:amy) { create(:user, first_name: "Amy", last_name: "Abbott") }
  let!(:beth) { create(:user, first_name: "Beth", last_name: "Baker") }

  before do
    sign_in(amy)
    visit(users_path)
    click_on("Add Friend")
    sign_out(amy)
  end

  it "shows a notification for a friendship request" do
    beth.reload
    sign_in(beth)
    visit(root_path)
    within(".notification-count") do
      expect(page).to have_content(1)
    end
    visit(notifications_path)
    within(".friend-container") do
      expect(page).to have_content('Amy Abbott')
    end
  end

  context "after viewing notifications" do
    it "removes notification" do
      beth.reload
      sign_in(beth)
      visit(notifications_path)
      visit(users_path)
      expect(page).not_to have_selector(".notification-count")
    end
  end
end
