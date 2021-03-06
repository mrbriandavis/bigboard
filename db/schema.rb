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

ActiveRecord::Schema.define(version: 20140929190948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: true do |t|
    t.integer  "network_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "group_id_for_yammer_post"
    t.boolean  "show_people_location",     default: false
    t.boolean  "show_project_location",    default: false
  end

  create_table "initiatives", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "manager_id"
    t.integer  "analyst_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id"
    t.boolean  "completed",   default: false, null: false
    t.integer  "security_id"
    t.boolean  "standing"
  end

  add_index "initiatives", ["board_id"], name: "index_initiatives_on_board_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name",       null: false
    t.integer  "board_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["board_id"], name: "index_locations_on_board_id", using: :btree

  create_table "networks", force: true do |t|
    t.integer  "nid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "networks", ["nid"], name: "index_networks_on_nid", unique: true, using: :btree

  create_table "people", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location_old"
    t.integer  "network_id"
    t.integer  "board_id"
    t.string   "new_project_alert"
    t.string   "permalink"
    t.integer  "location_id"
    t.string   "email"
  end

  add_index "people", ["board_id"], name: "index_people_on_board_id", using: :btree
  add_index "people", ["network_id"], name: "index_people_on_network_id", using: :btree
  add_index "people", ["team_id"], name: "index_people_on_team_id", using: :btree

  create_table "project_members", force: true do |t|
    t.integer  "project_id"
    t.integer  "person_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "location_old"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "initiative_id"
    t.string   "project_type"
    t.integer  "board_id"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "ship_date"
    t.boolean  "completed",     default: false, null: false
    t.boolean  "retro"
    t.integer  "location_id"
    t.text     "notes"
  end

  add_index "projects", ["board_id"], name: "index_projects_on_board_id", using: :btree
  add_index "projects", ["initiative_id"], name: "index_projects_on_initiative_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id"
    t.integer  "limit"
  end

  add_index "roles", ["board_id"], name: "index_roles_on_board_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id"
    t.boolean  "single_project"
    t.integer  "product_allocation"
    t.integer  "internal_projects_allocation"
    t.integer  "support_allocation"
    t.integer  "unallocated_allocation"
  end

  add_index "teams", ["board_id"], name: "index_teams_on_board_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.string   "access_token"
    t.integer  "network_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["network_id"], name: "index_users_on_network_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.integer  "board_id"
  end

  add_index "versions", ["board_id"], name: "index_versions_on_board_id", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
