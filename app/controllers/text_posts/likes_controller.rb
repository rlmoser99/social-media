# frozen_string_literal: true

module TextPosts
  class LikesController < LikesController
    before_action :set_likeable

    private

      def set_likeable
        @likeable = TextPost.find(params[:text_post_id])
      end
  end
end
