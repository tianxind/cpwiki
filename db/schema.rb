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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130902060149) do

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "sex"
    t.integer  "age_when_first_appear"
    t.date     "birth_date"
    t.integer  "horoscope"
    t.integer  "blood_type"
    t.string   "hair"
    t.string   "eye"
    t.string   "height"
    t.string   "weight"
    t.string   "occupation"
    t.text     "summary"
    t.integer  "profile_image"
    t.string   "work"
    t.integer  "creator_id"
    t.datetime "created_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "cp_id"
    t.integer  "user_id"
    t.text     "comment_text"
    t.datetime "date_time"
  end

  create_table "cps", :force => true do |t|
    t.integer  "creator_id",   :null => false
    t.datetime "created_at"
    t.integer  "seme_id",      :null => false
    t.integer  "uke_id",       :null => false
    t.integer  "category"
    t.string   "acronym"
    t.text     "summary"
    t.text     "wiki_content"
  end

  create_table "likes", :force => true do |t|
    t.integer "cp_id"
    t.integer "user_id"
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date_time"
    t.string   "filename"
  end

  create_table "tags", :force => true do |t|
    t.integer  "pos_x"
    t.integer  "pos_y"
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
