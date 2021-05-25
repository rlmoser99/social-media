# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user viewing notifications", type: :system do
  include CustomMatchers

  let!(:user) { create(:user) }
  let!(:friend) { create(:user, first_name: "Example", last_name: "Friend") }

  context "for friendships requests" do
    it "shows friend request in notification summary" do
      sign_in(friend)
      visit(users_path)
      click_on("Add Friend")
      sign_out(friend)
      user.reload
      sign_in(user)
      visit(notifications_path)

      within(".notification-summary") do
        expect(page).to have_content('Friend Request:')
        within(".friend-container") do
          expect(page).to have_content('Example Friend')
        end
      end
    end
  end

  context "for comments and likes on posts" do
    # Friendships for the 2 users and user's text and photo post
    let!(:friendship) { create(:friendship, user: user, friend: friend) }
    let!(:inverse_friendship) { create(:friendship, user: friend, friend: user) }
    let!(:text_post) { create(:text_post, author: user) }
    let!(:photo_post) { create(:photo_post, author: user) }

    it "shows correct notification summary" do
      sign_in(friend)
      visit(newsfeed_path)
      within '.photo-container' do
        within '.like-form' do
          find_submit_button.click
        end
        within '.comment-form' do
          fill_in("comment[content]", with: "Amazing!")
          find_submit_button.click
        end
      end
      within '.post-container' do
        within '.like-form' do
          find_submit_button.click
        end
        within '.comment-form' do
          fill_in("comment[content]", with: "Fun!")
          find_submit_button.click
        end
      end
      sign_out(friend)
      user.reload
      sign_in(user)
      visit(notifications_path)

      within(".notification-summary") do
        expect(page).to have_content('Example Friend liked your photo')
        expect(page).to have_link('your photo', href: photo_post_path(photo_post))
        expect(page).to have_content('Example Friend liked your post')
        expect(page).to have_link('your post', href: text_post_path(text_post))
      end
    end
  end
end
