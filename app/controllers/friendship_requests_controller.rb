# frozen_string_literal: true

class FriendshipRequestsController < ApplicationController
  before_action :find_friendship_request, only: %i[edit update destroy]

  def new
    @friendship_request = FriendshipRequest.new
  end

  def create
    @friendship_request = current_user.friendship_requests.build(friendship_request_params)
    return unless @friendship_request.save

    flash[:notice] = "Your friendship request has been sent."
    NotificationCreator.new(@friendship_request).call
    redirect_back fallback_location: users_path
  end

  def edit; end

  def update
    return unless @friendship_request.update(friendship_request_params)

    FriendshipManager.new(@friendship_request, friendship_request_params[:status]).call
    flash[:notice] = "The friendship request has been updated."
    redirect_back fallback_location: users_path
  end

  def destroy
    @friendship_request.destroy
    flash[:notice] = "Your friendship request has been deleted."
    redirect_back fallback_location: users_path
  end

  private

    def friendship_request_params
      params.permit(:user_id, :requested_friend_id, :status)
    end

    def find_friendship_request
      @friendship_request = FriendshipRequest.find(params[:id])
    end
end
