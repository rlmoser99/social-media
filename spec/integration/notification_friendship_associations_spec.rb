# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "friendship notification and user model associations" do
  # Users
  let!(:amy) { create(:user, first_name: 'Amy') }
  let!(:beth) { create(:user, first_name: 'Beth') }

  # Friendship Request - Notifiable Object
  let!(:amy_beth) { create(:friendship_request, user: amy, requested_friend: beth) }

  # Notification
  let!(:beth_notification) { create(:notification, :new, recipient: beth, notifiable: amy_beth) }

  context "when user gets a notification" do
    it "has a notification" do
      expect(beth.notifications).to include(beth_notification)
    end
  end

  context "when a notification is sent" do
    it "has a recipient" do
      expect(beth_notification.recipient).to eq(beth)
    end

    it "has a notifiable object" do
      expect(beth_notification.notifiable).to eq(amy_beth)
    end
  end
end
