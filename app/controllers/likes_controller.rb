# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def new
    @like = Like.new
  end

  def create
    @like = @likeable.likes.new(like_params)
    @like.author = current_user
    if @like.save
      NotificationCreator.new(@like, @like.likeable.author).call
      flash[:notice] = "Your like has been saved."
    else
      flash[:alert] = "Your like has not been saved."
    end
    redirect_back fallback_location: newsfeed_path
  end

  private

    def like_params
      params.permit(:user_id)
    end
end
