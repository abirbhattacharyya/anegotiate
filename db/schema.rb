# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090827121514) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attempted_tasks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.integer  "counter",    :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "completed_tasks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "image_url",  :default => "", :null => false
    t.text     "desc"
    t.integer  "points"
    t.integer  "cost"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lotteries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "points"
    t.integer  "won_points"
    t.integer  "lose_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "neg_categories", :force => true do |t|
    t.string   "category"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "negotiations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "negotiate_with"
    t.integer  "won_points"
    t.integer  "lost_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "task_done",        :default => true, :null => false
    t.boolean  "task_fail",        :default => true, :null => false
    t.boolean  "point_send",       :default => true, :null => false
    t.boolean  "point_receive",    :default => true, :null => false
    t.boolean  "lottery_win",      :default => true, :null => false
    t.boolean  "lottery_lost",     :default => true, :null => false
    t.boolean  "negotiation_win",  :default => true, :null => false
    t.boolean  "negotiation_lost", :default => true, :null => false
    t.boolean  "negotiate",        :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "own_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "qty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", :force => true do |t|
    t.integer  "sender_user_id"
    t.integer  "recipient_user_id"
    t.integer  "point",             :limit => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "item_id"
    t.text     "description"
    t.integer  "energy"
    t.integer  "risk"
    t.integer  "points"
    t.string   "style"
    t.string   "category",    :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.integer  "total_friends",                 :default => 0, :null => false
    t.integer  "points",                        :default => 0, :null => false
    t.integer  "energy",                        :default => 0, :null => false
    t.string   "style"
    t.string   "image_url"
    t.string   "location"
    t.string   "token"
    t.string   "secret"
    t.integer  "fb_uid"
    t.string   "email",          :limit => 100
    t.string   "email_hash"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
