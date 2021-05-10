# frozen_string_literal: true

class AddNotifiableToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :notifiable_id, :bigint
    add_column :notifications, :notifiable_type, :string
  end
end
