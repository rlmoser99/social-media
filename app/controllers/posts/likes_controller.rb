# frozen_string_literal: true

module Posts
  class LikesController < LikesController
    before_action :set_likeable

    private

      def set_likeable
        @likeable = Post.find(params[:post_id])
      end
  end
end
