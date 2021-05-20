# frozen_string_literal: true

class NewsFeedsController < ApplicationController
  def show
    @user = current_user
    @feed = Post.where(author_id: @user.friends).or(Post.where(author_id: @user))
                .includes(postable: { author: [avatar_attachment: :blob],
                                      comments: { author: [avatar_attachment: :blob] } })
                .order(created_at: :desc).page params[:page]
  end
end
