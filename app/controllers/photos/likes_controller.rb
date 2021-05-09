# frozen_string_literal: true

module Photos
  class LikesController < LikesController
    before_action :set_likeable

    private

      def set_likeable
        @likeable = Photo.find(params[:photo_id])
      end
  end
end
