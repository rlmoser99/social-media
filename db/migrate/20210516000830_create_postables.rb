# frozen_string_literal: true

class CreatePostables < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.bigint :postable_id
      t.string :postable_type
      t.bigint :author_id

      t.timestamps
    end
  end
end
