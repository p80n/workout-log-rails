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

ActiveRecord::Schema.define(version: 20191005164512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "equipment", force: :cascade do |t|
    t.text "name"
  end

  create_table "exercises", force: :cascade do |t|
    t.text    "name"
    t.integer "muscle_id"
    t.integer "equipment_id"
    t.text    "link"
    t.decimal "multiplier"
  end

  create_table "muscle_groups", force: :cascade do |t|
    t.text "name"
  end

  create_table "muscles", force: :cascade do |t|
    t.text    "name"
    t.integer "muscle_group_id"
  end

  create_table "routine_exercises", force: :cascade do |t|
    t.integer  "routine_id"
    t.integer  "exercise_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["exercise_id"], name: "index_routine_exercises_on_exercise_id", using: :btree
    t.index ["routine_id"], name: "index_routine_exercises_on_routine_id", using: :btree
  end

  create_table "routines", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.integer  "muscle_group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["muscle_group_id"], name: "index_routines_on_muscle_group_id", using: :btree
  end

  create_table "workout_sets", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "workout_id"
    t.integer  "exercise_id"
    t.integer  "reps",        array: true
    t.decimal  "weights",     array: true
    t.text     "notes"
    t.boolean  "warmup"
  end

  create_table "workouts", force: :cascade do |t|
    t.datetime "created_at"
  end

  add_foreign_key "routine_exercises", "exercises"
  add_foreign_key "routine_exercises", "routines"
  add_foreign_key "routines", "muscle_groups"
end
