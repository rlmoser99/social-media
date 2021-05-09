# frozen_string_literal: true

class AddLikeableToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :likeable_id, :bigint
    add_column :likes, :likeable_type, :string
  end
end
