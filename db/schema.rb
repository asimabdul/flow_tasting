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

ActiveRecord::Schema.define(version: 20151217185631) do

  create_table "events", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "event_key",          limit: 255
    t.text     "description",        limit: 65535
    t.datetime "starts_at"
    t.string   "venue",              limit: 255
    t.integer  "host_user_id",       limit: 4
    t.integer  "tasting_package_id", limit: 4
    t.integer  "receipt_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",              limit: 255
  end

  add_index "events", ["event_key"], name: "index_events_on_event_key", unique: true, using: :btree
  add_index "events", ["host_user_id"], name: "fk_rails_d65e2e32b2", using: :btree
  add_index "events", ["tasting_package_id"], name: "fk_rails_51033d7018", using: :btree

  create_table "guests", force: :cascade do |t|
    t.integer "user_id",    limit: 4
    t.integer "event_id",   limit: 4
    t.string  "rsvp_state", limit: 255
    t.string  "invite_key", limit: 255, null: false
  end

  add_index "guests", ["event_id"], name: "fk_rails_64ecc46b69", using: :btree
  add_index "guests", ["invite_key"], name: "index_guests_on_invite_key", unique: true, using: :btree
  add_index "guests", ["user_id"], name: "fk_rails_9b121eeada", using: :btree

  create_table "scorecards", force: :cascade do |t|
    t.string   "body",       limit: 255,   default: "0"
    t.integer  "rank",       limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "event_id",   limit: 4
    t.integer  "wine_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sweetness",  limit: 255
    t.string   "acidity",    limit: 255
    t.string   "finish",     limit: 255
    t.text     "comments",   limit: 65535
  end

  add_index "scorecards", ["event_id"], name: "fk_rails_f8d35e43d0", using: :btree
  add_index "scorecards", ["user_id"], name: "fk_rails_d4bdb5741c", using: :btree
  add_index "scorecards", ["wine_id"], name: "fk_rails_0a1e88df55", using: :btree

  create_table "tasting_packages", force: :cascade do |t|
    t.string   "name",       limit: 255,                         null: false
    t.decimal  "price",                  precision: 8, scale: 2, null: false
    t.string   "state",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "email",                  limit: 255,                 null: false
    t.string   "encrypted_password",     limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                              default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wine_packages", force: :cascade do |t|
    t.integer  "wine_id",            limit: 4
    t.integer  "tasting_package_id", limit: 4
    t.string   "wine_tasting_code",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wine_packages", ["tasting_package_id"], name: "fk_rails_f76832511a", using: :btree
  add_index "wine_packages", ["wine_id", "tasting_package_id", "wine_tasting_code"], name: "uniq_package", unique: true, using: :btree

  create_table "wines", force: :cascade do |t|
    t.string   "name",        limit: 255,                           null: false
    t.string   "region",      limit: 255
    t.string   "wine_type",   limit: 255
    t.text     "description", limit: 65535
    t.text     "fun_facts",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",                     precision: 8, scale: 2
    t.string   "producer",    limit: 255
    t.integer  "vintage",     limit: 4
  end

  add_index "wines", ["name"], name: "index_wines_on_name", using: :btree

  add_foreign_key "events", "tasting_packages"
  add_foreign_key "events", "users", column: "host_user_id"
  add_foreign_key "guests", "events"
  add_foreign_key "guests", "users"
  add_foreign_key "scorecards", "events"
  add_foreign_key "scorecards", "users"
  add_foreign_key "scorecards", "wines"
  add_foreign_key "wine_packages", "tasting_packages"
  add_foreign_key "wine_packages", "wines"
end
