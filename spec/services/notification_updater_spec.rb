# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationUpdater do
  # 2 Users & their Friendship Request
  let!(:amy) { create(:user, first_name: 'Amy') }
  let!(:beth) { create(:user, first_name: 'Beth') }
  let!(:amy_beth) { create(:friendship_request, user: amy, requested_friend: beth) }
  let!(:notification) { create(:notification, :new, recipient: beth, friendship_request: amy_beth) }

  context "before the notification is updated" do
    it "the read_at attribute is nil" do
      expect(notification.read_at).to be nil
    end
  end

  context "after the notification is updated" do
    it "the read_at attribute is no longer nil" do
      updater = NotificationUpdater.new(notification)
      updater.call
      expect(notification.read_at).not_to be nil
    end

    it "sets unread notification for recipient to 0" do
      updater = NotificationUpdater.new(notification)
      updater.call
      expect(beth.unread_notifications_count).to eq(0)
    end
  end
end
