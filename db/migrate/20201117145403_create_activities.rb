# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.references :receiver
      t.references :action
      t.integer :value, default: 0
      t.timestamps
    end
  end
end
