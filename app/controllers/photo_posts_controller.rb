# frozen_string_literal: true

class PhotoPostsController < ApplicationController
  before_action :authenticate_user!

  include Newsfeedable

  def show
    @photo_post = PhotoPost.where(id: params[:id])
                           .includes([{ author: [avatar_attachment: :blob] },
                                      { comments: { author: [avatar_attachment: :blob] } }]).first
  end

  def new
    @photo_post = PhotoPost.new
  end

  def create
    @photo_post = current_user.photo_posts.build(photo_params)

    if @photo_post.save
      newsfeed_addition(@photo_post)
      flash[:notice] = "Your photo has been posted!"
      redirect_back fallback_location: newsfeed_path
    else
      redirect_to @users
    end
  end

  private

    def photo_params
      params.require(:photo_post).permit(:image, :description)
    end
end
