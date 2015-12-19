# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151219133744) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.string   "file_id"
    t.string   "file_filename"
    t.integer  "file_size"
    t.string   "file_content_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "attachments", ["target_type", "target_id"], name: "index_attachments_on_target_type_and_target_id"

  create_table "molecular_campaigns", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "subject"
    t.text     "body"
    t.string   "recipients_query"
    t.datetime "sent_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "from"
    t.string   "from_name"
  end

  add_index "molecular_campaigns", ["owner_type", "owner_id"], name: "index_molecular_campaigns_on_owner_type_and_owner_id"

  create_table "molecular_events", force: :cascade do |t|
    t.integer  "subscription_id"
    t.string   "label"
    t.string   "value"
    t.text     "payload"
    t.datetime "triggered_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "molecular_events", ["subscription_id"], name: "index_molecular_events_on_subscription_id"

  create_table "molecular_recipients", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "molecular_subscriptions", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "recipient_id"
    t.integer  "status",       default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
