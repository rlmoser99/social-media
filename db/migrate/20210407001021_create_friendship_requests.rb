# frozen_string_literal: true

class CreateFriendshipRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friendship_requests do |t|
      t.bigint :user_id
      t.bigint :requested_friend_id
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
