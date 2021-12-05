# frozen_string_literal: true

class CreateRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards do |t|
      t.integer :category, index: true
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name, limit: 50, null: false
      t.text :description
      t.boolean :active, default: true, index: true
      t.string :image_url
      t.timestamps
    end
  end
end
