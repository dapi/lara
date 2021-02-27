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

ActiveRecord::Schema.define(version: 2021_02_27_160931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "User", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.index ["email"], name: "index_User_on_email", unique: true
    t.index ["remember_me_token"], name: "index_User_on_remember_me_token"
  end

  create_table "invites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "inviter_id", null: false
    t.string "full_name", null: false
    t.uuid "study_room_id", null: false
    t.string "key", null: false
    t.integer "role", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inviter_id"], name: "index_invites_on_inviter_id"
    t.index ["key"], name: "index_invites_on_key", unique: true
    t.index ["study_room_id"], name: "index_invites_on_study_room_id"
  end

  create_table "memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "study_room_id", null: false
    t.boolean "is_teacher", default: false, null: false
    t.boolean "is_student", default: false, null: false
    t.boolean "is_lead", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["study_room_id", "user_id"], name: "index_memberships_on_study_room_id_and_user_id", unique: true
    t.index ["study_room_id"], name: "index_memberships_on_study_room_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.bigint "chat_id", null: false
    t.text "text", null: false
    t.jsonb "payload", null: false
    t.bigint "message_id", null: false
    t.bigint "reply_message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "relationships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "parent_id", null: false
    t.uuid "children_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["children_id"], name: "index_relationships_on_children_id"
    t.index ["parent_id", "children_id"], name: "index_relationships_on_parent_id_and_children_id", unique: true
    t.index ["parent_id"], name: "index_relationships_on_parent_id"
  end

  create_table "students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "study_room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["study_room_id"], name: "index_students_on_study_room_id"
    t.index ["user_id", "study_room_id"], name: "index_students_on_user_id_and_study_room_id", unique: true
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "study_rooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "classroom_teacher_id"
    t.index ["classroom_teacher_id"], name: "index_study_rooms_on_classroom_teacher_id"
  end

  create_table "teachers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "study_room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["study_room_id", "user_id"], name: "index_teachers_on_study_room_id_and_user_id", unique: true
    t.index ["study_room_id"], name: "index_teachers_on_study_room_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "firstname"
    t.string "surname"
    t.string "middlename"
    t.string "phone"
    t.bigint "telegram_id", null: false
    t.jsonb "telegram_info", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["telegram_id"], name: "index_users_on_telegram_id", unique: true
  end

  add_foreign_key "invites", "study_rooms"
  add_foreign_key "invites", "users", column: "inviter_id"
  add_foreign_key "memberships", "study_rooms"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "relationships", "users", column: "children_id"
  add_foreign_key "relationships", "users", column: "parent_id"
  add_foreign_key "students", "study_rooms"
  add_foreign_key "students", "users"
  add_foreign_key "study_rooms", "users", column: "classroom_teacher_id"
  add_foreign_key "teachers", "study_rooms"
  add_foreign_key "teachers", "users"
end
