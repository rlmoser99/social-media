# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationCreator do
  # 2 Users & their Friendship Request
  let!(:amy) { create(:user, first_name: 'Amy') }
  let!(:beth) { create(:user, first_name: 'Beth') }
  let!(:amy_beth) { create(:friendship_request, user: amy, requested_friend: beth) }

  context "before the notification is created" do
    it "the requested friend has no notifications" do
      expect(beth.notifications.count).to eq(0)
    end

    it "the requested friend has no unread notification" do
      expect(beth.unread_notifications_count).to eq(0)
    end
  end

  context "after the notification is created" do
    it "creates a notification for requested friend" do
      creator = NotificationCreator.new(amy_beth, beth)
      creator.call
      expect(beth.notifications.count).to eq(1)
    end

    it "creates a new unread notification for requested friend" do
      creator = NotificationCreator.new(amy_beth, beth)
      creator.call
      expect(beth.unread_notifications_count).to eq(1)
    end
  end
end
