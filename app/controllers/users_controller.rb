# frozen_string_literal: true

class UsersController < ApplicationController
  def show; end

  def index
    @sent_requests = current_user.friendship_requests.includes([:requested_friend])
    @received_requests = current_user.requested_friendships.includes([:user])
    @other_users = find_other_users(@sent_requests, @received_requests)
    @friendship_request_statuses = friendship_request_status_options
  end

  private

    def find_other_users(sent_requests, received_requests)
      request_ids = sent_requests.map(&:requested_friend_id) + received_requests.map(&:user_id)
      User.all.reject { |user| request_ids.include?(user.id) || user == current_user }
    end

    def friendship_request_status_options
      FriendshipRequest.statuses.filter_map do |k, _v|
        k unless k == "pending"
      end
    end
end
