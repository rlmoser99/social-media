# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: current_user.friends)
                 .includes([:author, { comments: [:author] }]).sort_by(&:created_at).reverse
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Your post was created!"
      redirect_to posts_path
    else
      render :new
    end
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
