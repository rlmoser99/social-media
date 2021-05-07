# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.text :description
      t.bigint :author_id

      t.timestamps
    end
  end
end
