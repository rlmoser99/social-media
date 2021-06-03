# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :update_notifications, only: :index

  def index
    @notifications = current_user.notifications.includes([{ notifiable: %i[user likeable commentable author] }])
                                 .order(created_at: :desc).page params[:page]
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
