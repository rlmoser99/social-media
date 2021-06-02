# frozen_string_literal: true

class TextPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_text_post, only: %i[edit update destroy]
  before_action :require_authorization, only: %i[edit update]

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

  def edit; end

  def update
    if @text_post.update(text_post_params)
      redirect_to @text_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @text_post.destroy if authored_post?
    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_to newsfeed_path, notice: "Your post was successfully deleted." }
    end
  end

  private

    def text_post_params
      params.require(:text_post).permit(:id, :content)
    end

    def authored_post?
      @text_post.author == current_user
    end

    def set_text_post
      @text_post = TextPost.find(params[:id])
    end

    def require_authorization
      redirect_to :root unless authored_post?
    end
end
