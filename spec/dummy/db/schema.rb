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

ActiveRecord::Schema.define(version: 20151101200131) do

  create_table "swattr_issue_tags", force: :cascade do |t|
    t.integer  "issue_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "swattr_issues", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "project_id"
    t.integer  "author_id"
    t.integer  "assignee_id"
    t.integer  "priority_id"
    t.integer  "status_id"
    t.integer  "resolution_id"
    t.datetime "due_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "deleted_at"
  end

  add_index "swattr_issues", ["deleted_at"], name: "index_swattr_issues_on_deleted_at"

  create_table "swattr_priorities", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "position",    default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "swattr_projects", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "description"
    t.string   "location"
    t.integer  "author_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.string   "hero"
  end

  add_index "swattr_projects", ["deleted_at"], name: "index_swattr_projects_on_deleted_at"

  create_table "swattr_resolutions", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "position",    default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "swattr_settings", force: :cascade do |t|
    t.string   "title"
    t.string   "logo"
    t.integer  "per_page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "swattr_statuses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "position",    default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "swattr_tags", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "color"
    t.integer  "position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "swattr_tasks", force: :cascade do |t|
    t.string   "title"
    t.integer  "issue_id"
    t.integer  "author_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "swattr_users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",                   default: ""
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.datetime "deleted_at"
    t.string   "avatar"
  end

  add_index "swattr_users", ["confirmation_token"], name: "index_swattr_users_on_confirmation_token", unique: true
  add_index "swattr_users", ["deleted_at"], name: "index_swattr_users_on_deleted_at"
  add_index "swattr_users", ["email"], name: "index_swattr_users_on_email", unique: true
  add_index "swattr_users", ["invitation_token"], name: "index_swattr_users_on_invitation_token", unique: true
  add_index "swattr_users", ["invitations_count"], name: "index_swattr_users_on_invitations_count"
  add_index "swattr_users", ["invited_by_id"], name: "index_swattr_users_on_invited_by_id"
  add_index "swattr_users", ["reset_password_token"], name: "index_swattr_users_on_reset_password_token", unique: true
  add_index "swattr_users", ["unlock_token"], name: "index_swattr_users_on_unlock_token", unique: true

end
