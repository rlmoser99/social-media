# frozen_string_literal: true

class FriendshipRequestsController < ApplicationController
  def new
    @user = User.find_by(id: params[:user_id])
    @friendship_request = FriendshipRequest.new
  end

  def create
    @friendship_request = current_user.friendship_requests.build({ requested_friend_id: params[:user_id] })

    if @friendship_request.save
      flash[:notice] = "Your friendship request has been sent."
      redirect_to users_path
    else
      render :new
    end
  end
end
