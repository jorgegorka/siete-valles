# frozen_string_literal: true

class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name, limit: 50, null: false
      t.references :reward
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
