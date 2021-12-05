# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_17_163338) do

  create_table "achievements", charset: "utf8mb3", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "receiver_id"
    t.bigint "reward_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_id", "reward_id"], name: "index_achievements_on_receiver_id_and_reward_id"
    t.index ["receiver_id"], name: "index_achievements_on_receiver_id"
    t.index ["reward_id"], name: "index_achievements_on_reward_id"
    t.index ["uuid"], name: "index_achievements_on_uuid"
  end

  create_table "activities", charset: "utf8mb3", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "receiver_id"
    t.bigint "event_id"
    t.integer "value", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_activities_on_event_id"
    t.index ["receiver_id"], name: "index_activities_on_receiver_id"
    t.index ["uuid"], name: "index_activities_on_uuid"
  end

  create_table "conditions", charset: "utf8mb3", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "rule_id"
    t.integer "operation"
    t.bigint "event_id"
    t.integer "expression"
    t.integer "value"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_conditions_on_event_id"
    t.index ["rule_id"], name: "index_conditions_on_rule_id"
    t.index ["uuid"], name: "index_conditions_on_uuid"
  end

  create_table "events", charset: "utf8mb3", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name", limit: 50, null: false
    t.text "description"
    t.integer "value", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uuid"], name: "index_events_on_uuid"
  end

  create_table "receivers", charset: "utf8mb3", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "external_id"
    t.integer "points", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_id"], name: "index_receivers_on_external_id"
    t.index ["uuid"], name: "index_receivers_on_uuid"
  end

  create_table "rewards", charset: "utf8mb3", force: :cascade do |t|
    t.integer "category"
    t.string "uuid", limit: 36, null: false
    t.string "name", limit: 50, null: false
    t.text "description"
    t.boolean "active", default: true
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["active"], name: "index_rewards_on_active"
    t.index ["category"], name: "index_rewards_on_category"
    t.index ["uuid"], name: "index_rewards_on_uuid"
  end

  create_table "rules", charset: "utf8mb3", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name", limit: 50, null: false
    t.bigint "reward_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reward_id"], name: "index_rules_on_reward_id"
    t.index ["uuid"], name: "index_rules_on_uuid"
  end

end
