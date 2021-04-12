# frozen_string_literal: true

class NotificationUpdater
  def initialize(notification)
    @notification = notification
  end

  def call
    @notification.update(read_at: Time.zone.now)
    @notification.recipient.update(unread_notifications_count: 0)
  end
end
