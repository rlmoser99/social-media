# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.bigint :recipient_id
      t.bigint :friendship_request_id
      t.datetime :read_at

      t.timestamps
    end
  end
end
