# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @sent_requests = current_user.friendship_requests.includes([{ requested_friend: [avatar_attachment: :blob] }])
    @received_requests = current_user.requested_friendships.includes([{ user: [avatar_attachment: :blob] }])
    @other_users = find_other_users(@sent_requests, @received_requests)
    @friendship_request_statuses = friendship_request_status_options
  end

  def show
    @user = User.find_by(id: params[:id])
    @timeline = Post.where(author_id: @user)
                    .includes(postable: { author: [avatar_attachment: :blob],
                                          comments: { author: [avatar_attachment: :blob] } })
                    .order(created_at: :desc).page params[:page]
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
      User.with_attached_avatar
          .where.not(id: [
            current_user.id,
            sent_requests.pluck(:requested_friend_id),
            received_requests.pluck(:user_id)
          ].flatten)
    end

    def friendship_request_status_options
      FriendshipRequest.statuses.filter_map do |k, _v|
        k unless k == "pending"
      end
    end
end
