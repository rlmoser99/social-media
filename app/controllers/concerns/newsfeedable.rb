# frozen_string_literal: true

module Newsfeedable
  extend ActiveSupport::Concern

  def newsfeed_addition(post)
    current_user.posts.create!(postable: post)
  end
end
