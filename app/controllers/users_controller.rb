# frozen_string_literal: true

class UsersController < ApplicationController
  def show; end

  def index
    @sent_requests = current_user.friendship_requests.includes([:requested_friend])
    @received_requests = current_user.requested_friendships.includes([:user])
    @other_users = find_other_users
  end

  private

    def find_other_users
      User.all.reject { |user| user == current_user || current_requested_friends.include?(user) }
    end

    def current_requested_friends
      sent = current_user.friendship_requests.map(&:requested_friend)
      received = current_user.requested_friendships.map(&:user)
      sent + received
    end
end
