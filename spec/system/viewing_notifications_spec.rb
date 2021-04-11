# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user recieves a notification from friend request", type: :system do
  let!(:amy) { create(:user, email: 'amy@example.com') }
  let!(:beth) { create(:user, email: 'beth@example.com') }

  before do
    sign_in(amy)
    visit(users_path)
    click_on("Add Friend")
    sign_out(amy)
  end

  it "shows a notification for a friendship request" do
    sign_in(beth)
    visit(notifications_path)
    expect(page).to have_content('amy@example.com has sent you a friend request.')
  end
end
