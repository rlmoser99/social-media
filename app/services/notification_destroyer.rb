# frozen_string_literal: true

class NotificationDestroyer
  def initialize(notifiable, recipient)
    @notifiable = notifiable
    @recipient = recipient
  end

  def call
    notification = Notification.find_by(notifiable: @notifiable, recipient: @recipient)
    return unless notification.read_at.nil?

    notification.destroy
    @recipient.update(unread_notifications_count: @recipient.unread_notifications_count - 1)
  end
end
