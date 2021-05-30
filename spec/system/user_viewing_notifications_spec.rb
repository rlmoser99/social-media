# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user receiving notifications", type: :system do
  let!(:user) { create(:user) }
  let!(:friend) { create(:user, first_name: "Jubal", last_name: "Early") }

  context "for friendships requests" do
    let!(:friendship_request) { create(:friendship_request, user: friend, requested_friend: user) }
    let!(:notification) { create(:notification, :new, recipient: user, notifiable: friendship_request) }

    it "shows friend request in notification summary" do
      sign_in(user)
      visit(notifications_path)

      expect(find('.notification-summary')).to have_content('Friend Request:')
      expect(find('.friend-container')).to have_content('Jubal Early')
    end
  end

  context "for a like and comment on a photo post" do
    let!(:friendship) { create(:friendship, user: user, friend: friend) }
    let!(:inverse_friendship) { create(:friendship, user: friend, friend: user) }
    let!(:photo_post) { create(:photo_post, author: user, description: "Vacation picture") }
    let!(:comment) { create(:comment, author: friend, commentable: photo_post, content: "Amazing!") }
    let!(:comment_notification) { create(:notification, :new, recipient: user, notifiable: comment) }
    let!(:like) { create(:like, likeable: photo_post, author: friend) }
    let!(:like_notification) { create(:notification, :new, recipient: user, notifiable: like) }

    it "shows comment in notification summary" do
      sign_in(user)
      visit(newsfeed_path)

      within find('.photo-container') do
        expect(page).to have_content(photo_post.description)
        expect(page).to have_content(comment.content)
        expect(find('.like-count')).to have_content(1)
      end

      visit(notifications_path)

      within find('.notification-summary') do
        expect(page).to have_content(/Jubal Early commented "#{comment.content}"/)
        expect(page).to have_content(/Jubal Early liked/)
      end
    end
  end

  context "for a like and comment on a text post" do
    let!(:friendship) { create(:friendship, user: user, friend: friend) }
    let!(:inverse_friendship) { create(:friendship, user: friend, friend: user) }
    let!(:text_post) { create(:text_post, author: user, content: "Go Karts!") }
    let!(:comment) { create(:comment, author: friend, commentable: text_post, content: "Fun!") }
    let!(:comment_notification) { create(:notification, :new, recipient: user, notifiable: comment) }
    let!(:like) { create(:like, likeable: text_post, author: friend) }
    let!(:like_notification) { create(:notification, :new, recipient: user, notifiable: like) }

    it "shows comment in notification summary" do
      sign_in(user)
      visit(newsfeed_path)

      within find('.post-container') do
        expect(page).to have_content(text_post.content)
        expect(page).to have_content(comment.content)
        expect(find('.like-count')).to have_content(1)
      end

      visit(notifications_path)

      within find('.notification-summary') do
        expect(page).to have_content(/Jubal Early commented "#{comment.content}"/)
        expect(page).to have_content(/Jubal Early liked/)
      end
    end
  end
end
