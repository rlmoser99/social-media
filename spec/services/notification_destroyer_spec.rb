# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationDestroyer do
  context "when the notification has not been read" do
    let!(:user) { create(:user, unread_notifications_count: 1) }
    let!(:friend) { create(:user) }
    let!(:user_post) { create(:text_post, author: user, content: "Two by two. Hands of blue.") }
    let!(:friend_like) { create(:like, likeable: user_post, author: friend) }
    let!(:new_notification) { create(:notification, :new, notifiable: friend_like, recipient: user) }

    before do
      destroyer = NotificationDestroyer.new(friend_like, user)
      destroyer.call
    end

    it "the user's notifications do not include the like" do
      expect(user.notifications).not_to include(new_notification)
    end

    it "the user has zero unread notification" do
      expect(user.unread_notifications_count).to eq(0)
    end
  end

  context "when the notification has been read" do
    let!(:user) { create(:user) }
    let!(:friend) { create(:user) }
    let!(:user_post) { create(:text_post, author: user, content: "Two by two. Hands of blue.") }
    let!(:friend_like) { create(:like, likeable: user_post, author: friend) }
    let!(:read_notification) { create(:notification, notifiable: friend_like, recipient: user) }

    it "the user's notifications include the like" do
      destroyer = NotificationDestroyer.new(friend_like, user)
      destroyer.call
      expect(user.notifications).to include(read_notification)
    end
  end
end
