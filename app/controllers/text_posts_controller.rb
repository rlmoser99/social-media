# frozen_string_literal: true

class TextPostsController < ApplicationController
  include Newsfeedable

  def show
    @text_post = TextPost.where(id: params[:id])
                         .includes([{ author: [avatar_attachment: :blob] },
                                    { comments: { author: [avatar_attachment: :blob] } }]).first
  end

  def new
    @text_post = TextPost.new
  end

  def create
    @text_post = current_user.text_posts.build(text_post_params)
    if @text_post.save
      newsfeed_addition(@text_post)
      flash[:notice] = "Your post was created!"
      redirect_to newsfeed_path
    else
      render :new
    end
  end

  private

    def text_post_params
      params.require(:text_post).permit(:content)
    end
end
