# frozen_string_literal: true

module Posts
  class CommentsController < CommentsController
    before_action :set_commentable

    private

      def set_commentable
        @commentable = Post.find(params[:post_id])
      end
  end
end
