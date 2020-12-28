# frozen_string_literal: true

class CreateConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :conditions do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.references :rule
      t.integer :operation
      t.references :event
      t.integer :expression
      t.integer :value
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
