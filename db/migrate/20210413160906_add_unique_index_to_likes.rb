# frozen_string_literal: true

class AddUniqueIndexToLikes < ActiveRecord::Migration[6.1]
  def change
    add_index :likes, %i[user_id post_id], unique: true
  end
end
