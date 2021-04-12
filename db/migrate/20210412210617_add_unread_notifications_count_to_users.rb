# frozen_string_literal: true

class AddUnreadNotificationsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :unread_notifications_count, :integer, default: 0, null: false
  end
end
