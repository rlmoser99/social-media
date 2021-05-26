# frozen_string_literal: true

class PhotoPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo_post, only: %i[edit update destroy]
  before_action :require_authorization, only: %i[edit update destroy]

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

  def edit; end

  def update
    if @photo_post.update(photo_params)
      flash[:notice] = "Your post was updated!"
      redirect_to newsfeed_path
    else
      render :edit
    end
  end

  def destroy
    @photo_post.destroy

    redirect_to newsfeed_path
  end

  private

    def photo_params
      params.require(:photo_post).permit(:id, :image, :description)
    end

    def set_photo_post
      @photo_post = PhotoPost.find(params[:id])
    end

    def require_authorization
      redirect_to :root unless current_user == @photo_post.author
    end
end
