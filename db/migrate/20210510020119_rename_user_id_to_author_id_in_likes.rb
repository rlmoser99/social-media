# frozen_string_literal: true

class RenameUserIdToAuthorIdInLikes < ActiveRecord::Migration[6.1]
  def up
    rename_column :likes, :user_id, :author_id
  end

  def down
    rename_column :likes, :author_id, :user_id
  end
end
