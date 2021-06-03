# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def new
    @like = Like.new
  end

  def create
    @like = @likeable.likes.new
    @like.author = current_user
    NotificationCreator.new(@like, @like.likeable.author).call if @like.save && !authored_likeable?
    redirect_back fallback_location: newsfeed_path
  end

  def destroy
    @like = Like.find_by(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type], author: current_user)
    @like.destroy
    NotificationDestroyer.new(@like, @like.likeable.author).call
    redirect_back fallback_location: newsfeed_path
  end

  private

    def like_params
      params.permit(:id, :likeable_id, :likeable_type, :text_post_id, :photo_post_id)
    end

    def authored_likeable?
      @likeable.author == current_user
    end
end
