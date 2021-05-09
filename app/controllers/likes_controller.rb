# frozen_string_literal: true

class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = @likeable.likes.new(like_params)
    @like.user = current_user
    if @like.save
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
