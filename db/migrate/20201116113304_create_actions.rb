# frozen_string_literal: true

class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name, limit: 50, null: false
      t.text :description
      t.integer :value, default: 0, null: false
      t.timestamps
    end
  end
end
