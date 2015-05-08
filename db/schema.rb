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

ActiveRecord::Schema.define(version: 20141001142605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "student_courses", force: true do |t|
    t.string "name", limit: nil, null: false
  end

  add_index "student_courses", ["name"], name: "student_courses_name_key", unique: true, using: :btree

  create_table "student_groups", force: true do |t|
    t.string  "name",      limit: nil, null: false
    t.integer "course_id",             null: false
  end

  add_index "student_groups", ["name"], name: "student_groups_name_key", unique: true, using: :btree

  create_table "student_roles", force: true do |t|
    t.string "name", limit: nil, null: false
  end

  add_index "student_roles", ["name"], name: "student_roles_name_key", unique: true, using: :btree

  create_table "student_uploaded_documents", force: true do |t|
    t.string   "name",       limit: nil, null: false
    t.string   "filename",   limit: nil, null: false
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id", limit: 8,   null: false
  end

  create_table "students", force: true do |t|
    t.string   "first_name",  limit: nil, null: false
    t.string   "last_name",   limit: nil, null: false
    t.string   "middle_name", limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticket_num",  limit: nil
    t.string   "login",       limit: nil
    t.string   "password",    limit: nil
    t.integer  "group_id"
    t.string   "phone",       limit: nil
    t.string   "email",       limit: nil
    t.integer  "role_id",                              array: true
  end

  add_index "students", ["login"], name: "students_login_key", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
