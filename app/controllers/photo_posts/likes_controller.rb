# frozen_string_literal: true

module PhotoPosts
  class LikesController < LikesController
    before_action :set_likeable

    private

      def set_likeable
        @likeable = PhotoPost.find(params[:photo_post_id])
      end
  end
end
