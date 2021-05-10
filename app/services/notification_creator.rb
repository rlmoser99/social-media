# frozen_string_literal: true

class NotificationCreator
  def initialize(notifiable, recipient)
    @notifiable = notifiable
    @recipient = recipient
  end

  def call
    Notification.create(recipient: @recipient, notifiable: @notifiable)
    @recipient.update(unread_notifications_count: @recipient.unread_notifications_count + 1)
  end
end
