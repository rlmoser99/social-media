# frozen_string_literal: true

class AddIndextoLikes < ActiveRecord::Migration[6.1]
  def change
    add_index(:likes, %i[user_id likeable_id likeable_type], unique: true)
  end
end
