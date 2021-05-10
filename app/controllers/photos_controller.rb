# frozen_string_literal: true

class PhotosController < ApplicationController
  def show
    @photo = Photo.where(id: params[:id])
                  .includes([{ author: [avatar_attachment: :blob] },
                             { comments: { author: [avatar_attachment: :blob] } }]).first
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      flash[:notice] = "Your photo has been posted!"
      redirect_back fallback_location: newsfeed_path
    else
      redirect_to @users
    end
  end

  private

    def photo_params
      params.require(:photo).permit(:image, :description)
    end
end
