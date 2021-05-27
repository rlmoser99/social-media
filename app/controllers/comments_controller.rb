# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]
  before_action :require_authorization, only: %i[edit update destroy]

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

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Your comment was updated!"
      redirect_to newsfeed_path
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Your comment was deleted!"

    redirect_to newsfeed_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def authored_post?
      @comment.commentable.author == current_user
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def require_authorization
      redirect_to :root unless current_user == @comment.author
    end
end
