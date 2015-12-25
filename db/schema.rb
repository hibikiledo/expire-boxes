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

ActiveRecord::Schema.define(version: 20151225100429) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "box_id"
    t.string   "role",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accesses", ["box_id"], name: "index_accesses_on_box_id"
  add_index "accesses", ["user_id"], name: "index_accesses_on_user_id"

  create_table "boxes", force: :cascade do |t|
    t.string   "label",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "box_id"
    t.string   "label",       null: false
    t.date     "expire_date", null: false
    t.integer  "amount",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["box_id"], name: "index_items_on_box_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                      null: false
    t.string   "password",                   null: false
    t.boolean  "activated",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
