# frozen_string_literal: true

require "rails_helper"

RSpec.describe "notification for comment", type: :system do
  include CustomMatchers

  # 2 Users, 2 Friendships, and Post by User
  let!(:user) { create(:user) }
  let!(:friend) { create(:user, first_name: "Example", last_name: "Friend") }
  let!(:friendship) { create(:friendship, user: user, friend: friend) }
  let!(:inverse_friendship) { create(:friendship, user: friend, friend: user) }
  let!(:post) { create(:text_post, author: user, content: "best movie ever!") }

  xit "successfully shows count, notification, and resets" do
    sign_in(friend)
    visit(newsfeed_path)
    within(".like-form") do
      find_submit_button.click
    end

    within(".like-count") do
      expect(page).to have_content(1)
    end

    sign_out(friend)
    user.reload
    sign_in(user)
    visit(root_path)

    within(".notification-count") do
      expect(page).to have_content(1)
    end

    visit(notifications_path)

    within(".notification-summary") do
      expect(page).to have_content('Example Friend liked')
      expect(page).to have_link('your post', href: text_post_path(post))
    end

    visit(users_path)

    expect(page).not_to have_selector(".notification-count")
  end
end
