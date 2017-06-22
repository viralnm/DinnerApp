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

ActiveRecord::Schema.define(version: 20170622103109) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.string   "data_fingerprint",  limit: 255
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type", using: :btree

  create_table "foods", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "user_id",            limit: 4
    t.integer  "restaurant_id",      limit: 4
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.string   "photo_file_size",    limit: 255
    t.string   "photo_updated_at",   limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "foods", ["restaurant_id"], name: "index_foods_on_restaurant_id", using: :btree
  add_index "foods", ["user_id"], name: "index_foods_on_user_id", using: :btree

  create_table "opro_auth_grants", force: :cascade do |t|
    t.string   "code",                    limit: 255
    t.string   "access_token",            limit: 255
    t.string   "refresh_token",           limit: 255
    t.text     "permissions",             limit: 65535
    t.datetime "access_token_expires_at"
    t.integer  "user_id",                 limit: 4
    t.integer  "application_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "devise_token",            limit: 255
    t.integer  "devise_type",             limit: 4
  end

  add_index "opro_auth_grants", ["access_token"], name: "index_opro_auth_grants_on_access_token", unique: true, using: :btree
  add_index "opro_auth_grants", ["code"], name: "index_opro_auth_grants_on_code", unique: true, using: :btree
  add_index "opro_auth_grants", ["refresh_token"], name: "index_opro_auth_grants_on_refresh_token", unique: true, using: :btree

  create_table "opro_client_apps", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "app_id",      limit: 255
    t.string   "app_secret",  limit: 255
    t.text     "permissions", limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opro_client_apps", ["app_id", "app_secret"], name: "index_opro_client_apps_on_app_id_and_app_secret", unique: true, using: :btree
  add_index "opro_client_apps", ["app_id"], name: "index_opro_client_apps_on_app_id", unique: true, using: :btree

  create_table "restaurant_photos", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.string   "photo_file_size",    limit: 255
    t.string   "photo_updated_at",   limit: 255
    t.integer  "restaurant_id",      limit: 4
  end

  add_index "restaurant_photos", ["restaurant_id"], name: "index_restaurant_photos_on_restaurant_id", using: :btree

  create_table "restaurant_reviews", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "text",               limit: 255
    t.float    "rating",             limit: 24
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.string   "photo_file_size",    limit: 255
    t.string   "photo_updated_at",   limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "restaurant_id",      limit: 4
  end

  add_index "restaurant_reviews", ["restaurant_id"], name: "index_restaurant_reviews_on_restaurant_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "formatted_address", limit: 255
    t.float    "latitude",          limit: 24
    t.float    "longitude",         limit: 24
    t.float    "rating",            limit: 24
    t.boolean  "add_manual",                    default: true
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "static_pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "photo_url",              limit: 255
    t.string   "facebook_id",            limit: 255, default: "", null: false
    t.string   "google_id",              limit: 255, default: "", null: false
    t.string   "register_via",           limit: 255
    t.string   "photo_file_name",        limit: 255
    t.string   "photo_content_type",     limit: 255
    t.string   "photo_file_size",        limit: 255
    t.string   "photo_updated_at",       limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "devise_token",           limit: 255
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "restaurant_photos", "restaurants"
  add_foreign_key "restaurant_reviews", "restaurants"
end
