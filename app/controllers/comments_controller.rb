# frozen_string_literal: true

class CommentsController < ApplicationController
  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    return unless @comment.save

    flash[:notice] = "Your comment was created!"
    redirect_back fallback_location: posts_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end
end
