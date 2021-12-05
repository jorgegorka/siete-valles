# frozen_string_literal: true

class CreateReceivers < ActiveRecord::Migration[6.0]
  def change
    create_table :receivers do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :external_id, index: true, unique: true
      t.integer :points, default: 0
      t.timestamps
    end
  end
end
