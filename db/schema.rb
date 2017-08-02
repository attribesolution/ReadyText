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

ActiveRecord::Schema.define(version: 20170801123739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.date "booking_date"
    t.time "booking_time"
    t.string "party_name"
    t.integer "size"
    t.string "phone"
    t.text "notes"
    t.string "type"
    t.integer "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "status"
    t.boolean "checkin", default: false
    t.boolean "sequence_in_progress", default: false
    t.integer "wait_in_minutes", default: 0
    t.integer "customer_id"
    t.index ["deleted_at"], name: "index_bookings_on_deleted_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "phone_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "phone"
    t.integer "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "message_templates", force: :cascade do |t|
    t.string "name"
    t.text "template"
    t.integer "sort_order"
    t.integer "restaurant_id"
    t.integer "next_delay", default: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "restaurant_id"
    t.text "template"
    t.string "recipent"
    t.integer "message_type", default: 0
    t.string "api_message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "stripe_id"
    t.float "price"
    t.string "interval"
    t.text "features"
    t.boolean "highlight"
    t.integer "display_order"
    t.string "plan_type"
    t.integer "lower_limit"
    t.integer "upper_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.integer "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "stripe_id"
    t.integer "plan_id"
    t.string "last_four"
    t.integer "coupon_id"
    t.string "card_type"
    t.float "current_price"
    t.integer "user_id"
    t.datetime "expired_at"
    t.boolean "in_trial"
    t.string "subs_type"
    t.string "status"
    t.datetime "started_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.string "phone"
    t.integer "restaurant_id"
    t.integer "country_id"
    t.string "time_zone", default: "UTC"
    t.integer "no_show_threshold", default: 30
    t.datetime "trial_ends_at"
    t.boolean "in_trial", default: true
    t.string "stripe_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
