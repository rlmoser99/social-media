# frozen_string_literal: true

class RemovePostIdFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :post_id, :bigint
  end
end
