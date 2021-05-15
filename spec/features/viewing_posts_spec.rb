# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Log in required to view friends posts" do
  # Users
  let!(:amy) { create(:user) }
  let!(:beth) { create(:user) }
  let!(:carl) { create(:user) }

  # Friendships
  let!(:amy_beth) { create(:friendship, user: amy, friend: beth) }
  let!(:beth_amy) { create(:friendship, user: beth, friend: amy) }

  # Posts
  let!(:beth_post) { create(:text_post, author: beth, content: "Friends post should be viewable.") }
  let!(:carl_post) { create(:text_post, author: carl, content: "This post should not be viewable.") }

  context "User can see friends posts" do
    scenario "with valid credentials" do
      visit "/"
      click_link "Log In"
      fill_in "Email", with: amy.email
      fill_in "Password", with: amy.password
      click_on("Log in")
      expect(page).to have_content "Signed in successfully."

      visit "/newsfeed"
      expect(page).to have_content "Friends post should be viewable."
      expect(page).not_to have_content "This post should not be viewable."
    end
  end

  context "User can not see posts" do
    scenario "with invalid credentials" do
      visit "/"
      click_link "Log In"
      fill_in "Email", with: amy.email
      fill_in "Password", with: "foo"
      click_on("Log in")

      expect(page).to have_content "Invalid Email or password."
      expect(page).not_to have_content "Post Index"
    end
  end
end
