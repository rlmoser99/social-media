# frozen_string_literal: true

class NewsFeedsController < ApplicationController
  def show
    posts = Post.where(author_id: current_user.friends).or(Post.where(author_id: current_user))
                .includes([{ author: [avatar_attachment: :blob] },
                           { comments: { author: [avatar_attachment: :blob] } }]).sort_by(&:created_at).reverse
    photos = Photo.where(author_id: current_user.friends).or(Photo.where(author_id: current_user))
                  .includes([{ author: [avatar_attachment: :blob] },
                             { comments: { author: [avatar_attachment: :blob] } }]).sort_by(&:created_at).reverse
    @feed = posts + photos
  end
end
