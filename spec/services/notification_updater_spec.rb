# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationUpdater do
  # 2 Users, a Friendship Request, and a Notification
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:friendship_request) { create(:friendship_request, user: user, requested_friend: friend) }
  let!(:notification) { create(:notification, :new, recipient: friend, notifiable: friendship_request) }

  before do
    NotificationUpdater.new(notification).call
  end

  it "updates the notification's read_at attribute to no longer be nil" do
    expect(notification.read_at).not_to be nil
  end

  it "sets the recipient's unread_notification_count to 0" do
    expect(friend.unread_notifications_count).to eq(0)
  end
end
