# frozen_string_literal: true

class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = current_user.likes.build(like_params)
    return unless @like.save

    flash[:notice] = "Your like has been saved."
    redirect_back fallback_location: posts_path
  end

  private

    def like_params
      params.permit(:user_id, :post_id)
    end
end
