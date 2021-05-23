# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user viewing personal timeline", type: :system do
  # Users
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }

  # Friendships
  let!(:user_friend) { create(:friendship, user: user, friend: friend) }
  let!(:friend_user) { create(:friendship, user: friend, friend: user) }

  # Text Posts
  let!(:user_post) { create(:text_post, author: user, content: "My post should be viewable.") }
  let!(:friend_post) { create(:text_post, author: friend, content: "Friends post should not be viewable.") }

  it "shows correct posts" do
    user.reload
    sign_in(user)
    visit(user_path(user))

    expect(page).to have_content(user_post.content)
    expect(page).to have_no_content(friend_post.content)
  end
end
