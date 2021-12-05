# frozen_string_literal: true

class CreateAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :achievements do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.references :receiver
      t.references :reward
      t.timestamps
    end

    add_index :achievements, %i[receiver_id reward_id]
  end
end
