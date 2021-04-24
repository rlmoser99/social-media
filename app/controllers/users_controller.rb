# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @sent_requests = current_user.friendship_requests.includes([:requested_friend])
    @received_requests = current_user.requested_friendships.includes([:user])
    @other_users = find_other_users(@sent_requests, @received_requests)
    @friendship_request_statuses = friendship_request_status_options
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated!"
      redirect_back fallback_location: @user
    else
      flash[:alert] = "Your profile has not been updated!"
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:avatar)
    end

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
