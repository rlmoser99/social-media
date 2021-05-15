# frozen_string_literal: true

module PhotoPosts
  class CommentsController < CommentsController
    before_action :set_commentable

    private

      def set_commentable
        @commentable = PhotoPost.find(params[:photo_post_id])
      end
  end
end
