# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.author = current_user
    return unless @comment.save

    NotificationCreator.new(@comment, @comment.commentable.author).call unless authored_post?
    flash[:notice] = "Your comment was created!"
    redirect_back fallback_location: newsfeed_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def authored_post?
      @comment.commentable.author == current_user
    end
end
