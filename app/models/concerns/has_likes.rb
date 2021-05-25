# frozen_string_literal: true

module HasLikes
  extend ActiveSupport::Concern

  def find_like_by_user(user)
    Like.find_by(likeable: self, author: user)
  end
end
