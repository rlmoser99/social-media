# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user viewing newsfeed", type: :system do
  # Users
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:non_friend) { create(:user) }

  # Friendships
  let!(:user_friend) { create(:friendship, user: user, friend: friend) }
  let!(:friend_user) { create(:friendship, user: friend, friend: user) }

  # Text Posts
  let!(:user_post) { create(:text_post, author: user, content: "My post should be viewable.") }
  let!(:friend_post) { create(:text_post, author: friend, content: "Friends post should be viewable.") }
  let!(:non_friend_post) do
    create(:text_post, author: non_friend, content: "A non-friend post should not be viewable.")
  end

  it "shows correct posts" do
    user.reload
    sign_in(user)
    visit(newsfeed_path)

    within(".newsfeed") do
      expect(page).to have_content(user_post.content)
      expect(page).to have_content(friend_post.content)
      expect(page).to have_no_content(non_friend_post.content)
    end
  end
end
