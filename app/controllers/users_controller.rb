# frozen_string_literal: true

class UsersController < ApplicationController
  def show; end

  def index
    @friends = find_requested_friends
    @other_users = find_other_users
  end

  private

    def find_requested_friends
      sent = current_user.friendship_requests.map(&:requested_friend)
      received = current_user.requested_friendships.map(&:user)
      sent + received
    end

    def find_other_users
      User.all.reject { |user| user == current_user || @friends.include?(user) }
    end
end
