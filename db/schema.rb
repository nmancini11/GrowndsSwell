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

ActiveRecord::Schema.define(:version => 20110808172908) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oauth_token"
  end

  create_table "businesses", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "name"
  end

  add_index "businesses", ["email"], :name => "index_businesses_on_email", :unique => true
  add_index "businesses", ["reset_password_token"], :name => "index_businesses_on_reset_password_token", :unique => true

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email_address"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hours", :force => true do |t|
    t.integer  "venue_id"
    t.integer  "day"
    t.time     "open_time"
    t.time     "close_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", :force => true do |t|
    t.integer  "itinerary_id"
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "itineraries", :force => true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.text     "summary"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "itinerary_invites", :force => true do |t|
    t.integer  "itinerary_id"
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pending_itinerary_invites", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "invite_id"
  end

  create_table "plans", :force => true do |t|
    t.integer  "child_id"
    t.integer  "parent_id"
    t.integer  "itinerary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.datetime "monday_open"
    t.datetime "monday_close"
    t.datetime "tuesday_open"
    t.datetime "tuesday_close"
    t.datetime "wednesday_open"
    t.datetime "wednesday_close"
    t.datetime "thursday_open"
    t.datetime "thursday_close"
    t.datetime "friday_open"
    t.datetime "friday_close"
    t.datetime "saturday_open"
    t.datetime "saturday_close"
    t.datetime "sunday_open"
    t.datetime "sunday_close"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "schedule_business_id"
  end

  create_table "swells", :force => true do |t|
    t.string   "name"
    t.string   "deal_info"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "radius"
    t.integer  "limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "name"
    t.string   "gender"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venue_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venue_types_venues", :id => false, :force => true do |t|
    t.integer "venue_id"
    t.integer "venue_type_id"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_id"
    t.boolean  "active"
    t.string   "fsvid"
  end

end
