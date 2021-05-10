# frozen_string_literal: true

class RemoveFriendshipRequestIdFromNotification < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :friendship_request_id, :bigint
  end
end
