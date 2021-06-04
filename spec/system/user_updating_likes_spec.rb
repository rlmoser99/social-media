# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user adding and removing likes ", type: :system do
  include CustomMatchers

  # 2 Users, 2 Friendships, and Friend's Post
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:user_friend) { create(:friendship, user: user, friend: friend) }
  let!(:friend_user) { create(:friendship, user: friend, friend: user) }
  let!(:friend_post) { create(:text_post, author: friend, content: "Two by two. Hands of blue.") }

  it "correctly shows the like count and unread notifications changing" do
    sign_in(user)
    visit(newsfeed_path)

    expect(friend.unread_notifications_count).to eq(0)
    within '.like-count' do
      expect(page).to have_content("0")
    end

    within '.like-form' do
      find_submit_button.click
    end

    within '.like-count' do
      expect(page).to have_content("1")
    end
    expect(friend.reload.unread_notifications_count).to eq(1)

    within '.unlike-form' do
      find_submit_button.click
    end

    within '.like-count' do
      expect(page).to have_content("0")
    end
    expect(friend.reload.unread_notifications_count).to eq(0)
  end
end
