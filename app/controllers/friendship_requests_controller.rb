# frozen_string_literal: true

class FriendshipRequestsController < ApplicationController
  def new
    @friendship_request = FriendshipRequest.new
    @friend = User.find_by(id: params[:requested_friend_id])
  end

  def create
    @friendship_request = current_user.friendship_requests.build(friendship_request_params)

    if @friendship_request.save
      flash[:notice] = "Your friendship request has been sent."
      redirect_to users_path
    else
      flash.now[:notice] = "Your friendship request was not sent."
      render :new
    end
  end

  def edit
    @friendship_request = FriendshipRequest.find(params[:id])
    @status_options = possible_statuses
  end

  def update
    @friendship_request = FriendshipRequest.find(params[:id])

    if @friendship_request.update(friendship_request_params)
      flash[:notice] = "Your friendship request has been updated."
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def destroy
    @friendship_request = FriendshipRequest.find(params[:id])
    @friendship_request.destroy
    flash[:notice] = "Your friendship request has been deleted."
    redirect_to root_path
  end

  private

    def friendship_request_params
      params.require(:friendship_request).permit(:user_id, :requested_friend_id, :status)
    end

    def possible_statuses
      FriendshipRequest.statuses.filter_map do |k, _v|
        [k.humanize.capitalize, k] unless k == "pending"
      end
    end
end
