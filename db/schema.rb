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

ActiveRecord::Schema.define(version: 20160725201544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "answerer_id"
    t.integer  "answerer_type"
    t.string   "answer_text"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "owner_id"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "zip_code"
    t.string   "phone"
    t.string   "image_url"
    t.string   "website_url"
    t.point    "location"
    t.string   "categories"
    t.string   "yelp_id"
    t.boolean  "is_local"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "business_id"
    t.string   "question_text"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "user_id"
    t.boolean  "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["business_id"], name: "index_recommendations_on_business_id", using: :btree
    t.index ["user_id"], name: "index_recommendations_on_user_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "responder_id"
    t.string   "responder_type"
    t.boolean  "hiring"
    t.boolean  "glutFree"
    t.boolean  "musicians"
    t.boolean  "lgbt"
    t.boolean  "localFood"
    t.boolean  "minorityOwned"
    t.boolean  "livWage"
    t.boolean  "petFriend"
    t.boolean  "artsCrafts"
    t.boolean  "charNonprof"
    t.boolean  "sustain"
    t.boolean  "veganPeta"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username",                            null: false
    t.string   "zip_code",                            null: false
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "recommendations", "users"
end
