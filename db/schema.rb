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

ActiveRecord::Schema.define(version: 20140201132627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_assignments", force: true do |t|
    t.integer  "student_id"
    t.integer  "classroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "class_assignments", ["classroom_id"], name: "index_class_assignments_on_classroom_id", using: :btree
  add_index "class_assignments", ["student_id"], name: "index_class_assignments_on_student_id", using: :btree

  create_table "classrooms", force: true do |t|
    t.string   "name"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
  end

  add_index "classrooms", ["school_id"], name: "index_classrooms_on_school_id", using: :btree

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

  create_table "demerits", force: true do |t|
  end

  create_table "marks", force: true do |t|
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "meeting_id"
    t.integer  "content_id"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "marks", ["content_id"], name: "index_marks_on_content_id", using: :btree
  add_index "marks", ["meeting_id"], name: "index_marks_on_meeting_id", using: :btree
  add_index "marks", ["student_id"], name: "index_marks_on_student_id", using: :btree
  add_index "marks", ["teacher_id"], name: "index_marks_on_teacher_id", using: :btree

  create_table "meetings", force: true do |t|
    t.integer  "classroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meetings", ["classroom_id"], name: "index_meetings_on_classroom_id", using: :btree

  create_table "merits", force: true do |t|
  end

  create_table "schools", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.string   "student_id", null: false
  end

  add_index "students", ["school_id"], name: "index_students_on_school_id", using: :btree

  create_table "teachers", force: true do |t|
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "email",                  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "school_id"
  end

  add_index "teachers", ["email"], name: "index_teachers_on_email", unique: true, using: :btree
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true, using: :btree
  add_index "teachers", ["school_id"], name: "index_teachers_on_school_id", using: :btree

end
