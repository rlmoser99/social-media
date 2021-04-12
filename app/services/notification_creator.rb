# frozen_string_literal: true

class NotificationCreator
  def initialize(friendship_request)
    @friendship_request = friendship_request
  end

  def call
    recipient = @friendship_request.requested_friend
    Notification.create(recipient: recipient, friendship_request: @friendship_request)
    recipient.update(unread_notifications_count: recipient.unread_notifications_count + 1)
  end
end
