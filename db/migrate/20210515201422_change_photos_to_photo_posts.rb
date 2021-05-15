# frozen_string_literal: true

class ChangePhotosToPhotoPosts < ActiveRecord::Migration[6.1]
  def change
    rename_table :photos, :photo_posts
  end
end
