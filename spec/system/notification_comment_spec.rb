# frozen_string_literal: true

require "rails_helper"

RSpec.describe "notification for comment", type: :system do
  include CustomMatchers

  # 2 Users, 2 Friendships, and Post by User
  let!(:user) { create(:user) }
  let!(:friend) { create(:user, first_name: "Example", last_name: "Friend") }
  let!(:friendship) { create(:friendship, user: user, friend: friend) }
  let!(:inverse_friendship) { create(:friendship, user: friend, friend: user) }
  let!(:post) { create(:text_post, author: user, content: "movie recommendation?") }

  it "successfully shows count, notification, and resets" do
    sign_in(friend)
    visit(newsfeed_path)
    within(".comment-form") do
      fill_in("comment[content]", with: "Serenity")
      find_submit_button.click
    end
    expect(page).to have_content("Serenity")

    expect(user.reload.unread_notifications_count).to eq(1)
  end
end
