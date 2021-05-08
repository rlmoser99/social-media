# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user views newsfeed", type: :system do
  # Users
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:non_friend) { create(:user) }

  # Friendships
  let!(:user_friend) { create(:friendship, user: user, friend: friend) }
  let!(:friend_user) { create(:friendship, user: friend, friend: user) }

  # Posts
  let!(:user_post) { create(:post, author: user, content: "My post should be viewable.") }
  let!(:friend_post) { create(:post, author: friend, content: "Friends post should be viewable.") }
  let!(:non_friend_post) { create(:post, author: non_friend, content: "A non-friend post should not be viewable.") }

  before do
    user.reload
    sign_in(user)
  end

  it "shows your friends posts" do
    visit(newsfeed_path)
    within(".newsfeed") do
      expect(page).to have_content(friend_post.content)
    end
  end

  it "shows your own posts" do
    visit(newsfeed_path)
    within(".newsfeed") do
      expect(page).to have_content(user_post.content)
    end
  end

  it "does not show non-friend posts" do
    visit(newsfeed_path)
    within(".newsfeed") do
      expect(page).not_to have_content(non_friend_post.content)
    end
  end
end
