# frozen_string_literal: true

class NotificationsController < ApplicationController
  after_action :update_notifications, only: :index

  def index
    @notifications = current_user.notifications.includes([{ notifiable: %i[user likeable commentable author] }])
                                 .sort_by(&:created_at).reverse
    @friendship_request_statuses = friendship_request_status_options
  end

  private

    def update_notifications
      current_user.notifications.unread.each { |notification| NotificationUpdater.new(notification).call }
    end

    def friendship_request_status_options
      FriendshipRequest.statuses.filter_map do |k, _v|
        k unless k == "pending"
      end
    end
end
