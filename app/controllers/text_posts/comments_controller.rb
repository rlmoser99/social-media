# frozen_string_literal: true

module TextPosts
  class CommentsController < CommentsController
    before_action :set_commentable

    private

      def set_commentable
        @commentable = TextPost.find(params[:text_post_id])
      end
  end
end
