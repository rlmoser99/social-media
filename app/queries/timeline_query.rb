# frozen_string_literal: true

class TimelineQuery
  def initialize(user)
    @user = user
  end

  def call
    posts = find_posts
    photos = find_photos
    newsfeed = posts + photos
    newsfeed.sort! { |a, b| -(a.created_at <=> b.created_at) }
  end

  private

    def find_posts
      TextPost.where(author_id: @user.friends).or(TextPost.where(author_id: @user))
              .includes([{ author: [avatar_attachment: :blob] }, { comments: { author: [avatar_attachment: :blob] } }])
              .order(created_at: :desc)
    end

    def find_photos
      PhotoPost.where(author_id: @user.friends).or(PhotoPost.where(author_id: @user))
               .includes([{ author: [avatar_attachment: :blob] }, { comments: { author: [avatar_attachment: :blob] } }])
               .order(created_at: :desc)
    end
end
