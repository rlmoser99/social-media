# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.bigint :post_id
      t.bigint :author_id

      t.timestamps
    end
  end
end
