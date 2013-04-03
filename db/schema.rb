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

ActiveRecord::Schema.define(:version => 20121129185611) do

  create_table "auctions", :force => true do |t|
    t.integer  "item_id"
    t.integer  "seller_id"
    t.float    "bid_amount"
    t.integer  "highest_bidder"
    t.integer  "state"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.datetime "end_time"
    t.integer  "job_id"
  end

  create_table "cards", :force => true do |t|
    t.string   "cvv"
    t.date     "expiry_date"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.binary   "card_number"
    t.binary   "card_number_key"
    t.binary   "card_number_iv"
    t.string   "type"
  end

  add_index "cards", ["user_id"], :name => "index_cards_on_user_id"

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image_url"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "item_categories", :force => true do |t|
    t.integer  "item_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "price"
    t.text     "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "manufacturer"
    t.integer  "sold_count",   :default => 0
    t.boolean  "featured",     :default => false
    t.integer  "user_id"
    t.boolean  "activated",    :default => true
    t.boolean  "auction_flag", :default => false
    t.integer  "auction_id"
    t.integer  "availability"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "item_id"
    t.integer  "cart_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "quantity",       :default => 1
    t.integer  "user_id"
    t.integer  "line_item_type"
    t.integer  "auction_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "item_id"
    t.integer  "state"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "item_quantity"
    t.text     "shipping_address"
    t.text     "billing_address"
    t.float    "price"
    t.float    "total_price"
    t.integer  "transaction_id"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "buyer_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.text     "address"
    t.integer  "zipcode"
    t.integer  "user_type"
    t.boolean  "activated",              :default => true
    t.text     "auctions"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
