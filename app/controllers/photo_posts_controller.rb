# frozen_string_literal: true

class PhotoPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo_post, only: %i[edit update destroy]
  before_action :require_authorization, only: %i[edit update]

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
      redirect_to @photo_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo_post.destroy if authored_post?
    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_to newsfeed_path, notice: "Your post was successfully deleted." }
    end
  end

  private

    def photo_params
      params.require(:photo_post).permit(:id, :image, :description)
    end

    def authored_post?
      @photo_post.author == current_user
    end

    def set_photo_post
      @photo_post = PhotoPost.find(params[:id])
    end

    def require_authorization
      redirect_to :root unless authored_post?
    end
end
