# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Log in required to view friends posts and its comments" do
  # Users
  let!(:amy) { create(:user) }
  let!(:beth) { create(:user) }
  let!(:carl) { create(:user) }

  # Friendships
  let!(:amy_beth) { create(:friendship, user: amy, friend: beth) }
  let!(:beth_amy) { create(:friendship, user: beth, friend: amy) }

  let!(:beth_carl) { create(:friendship, user: beth, friend: carl) }
  let!(:carl_beth) { create(:friendship, user: carl, friend: beth) }

  # Posts
  let!(:friend_post) { create(:post, author: beth, content: "Friends post should be viewable.") }
  let!(:user_post) { create(:post, author: carl, content: "This post should not be viewable.") }

  # Comment
  let!(:user_comment) do
    create(:comment, author: carl, commentable: friend_post, content: "This comment should be viewable.")
  end

  context "User can see friends posts and all its comments" do
    scenario "with valid credentials" do
      visit "/"
      click_link "Log In"
      fill_in "Email", with: amy.email
      fill_in "Password", with: amy.password
      click_on("Log in")
      expect(page).to have_content "Friends post should be viewable."
      expect(page).not_to have_content "This post should not be viewable."
      expect(page).to have_content "This comment should be viewable."
    end
  end
end
