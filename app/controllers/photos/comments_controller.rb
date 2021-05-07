# frozen_string_literal: true

module Photos
  class CommentsController < CommentsController
    before_action :set_commentable

    private

      def set_commentable
        @commentable = Photo.find(params[:photo_id])
      end
  end
end
