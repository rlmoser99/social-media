# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do
      add_column :users, :first_name, :string
      add_column :users, :last_name, :string
    end
  end
end
