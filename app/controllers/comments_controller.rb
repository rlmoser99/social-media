# frozen_string_literal: true

class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  include RecordHelper

  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]
  before_action :require_authorization, only: %i[edit update]

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.author = current_user

    respond_to do |format|
      if @comment.save
        NotificationCreator.new(@comment, @comment.commentable.author).call unless authored_post?
        comment = Comment.new
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(dom_id_for_records(@commentable, comment),
                                                    partial: "comments/form",
                                                    locals: { commentable: @commentable, comment: comment })
        end
        format.html { redirect_to @commentable }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(dom_id_for_records(@commentable, @comment),
                                                    partial: "comments/form",
                                                    locals: { comment: @comment, commentable: @commentable })
        end
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless authored_comment?

    NotificationDestroyer.new(@comment, @comment.commentable.author).call
    @comment.destroy
    respond_to do |format|
      format.turbo_stream {}
      format.html { redirect_to @comment.commentable }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def authored_post?
      @commentable.author == current_user
    end

    def authored_comment?
      @comment.author == current_user
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def require_authorization
      redirect_to :root unless authored_comment?
    end
end
