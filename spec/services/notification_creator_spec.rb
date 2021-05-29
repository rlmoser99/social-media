# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationCreator do
  # 2 Users & their Friendship Request
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:friendship_request) { create(:friendship_request, user: user, requested_friend: friend) }

  before do
    NotificationCreator.new(friendship_request, friend).call
  end

  it "creates a notification for requested friend" do
    expect(friend.notifications.count).to eq(1)
  end

  it "increases the requested friend's unread_notification_count" do
    expect(friend.unread_notifications_count).to eq(1)
  end
end
