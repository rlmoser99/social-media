# frozen_string_literal: true

class NewsFeedsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @feed = Post.where(author_id: @user.friends).or(Post.where(author_id: @user))
                .includes(postable: { author: [avatar_attachment: :blob],
                                      image_attachment: [:blob],
                                      likes: [:author],
                                      comments: { author: [avatar_attachment: :blob] } })
                .order(created_at: :desc).page params[:page]
  end
end
