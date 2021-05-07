# frozen_string_literal: true

class NewsFeedsController < ApplicationController
  def show
    @posts = Post.where(author_id: current_user.friends).or(Post.where(author_id: current_user))
                 .includes([:author, { comments: [:author] }]).sort_by(&:created_at).reverse
  end
end
