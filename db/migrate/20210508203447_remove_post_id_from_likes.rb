# frozen_string_literal: true

class RemovePostIdFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_column :likes, :post_id, :bigint
  end
end
