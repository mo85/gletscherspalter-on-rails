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

ActiveRecord::Schema.define(:version => 20101028111423) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "number"
    t.string   "city"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment",                        :default => ""
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "date"
    t.integer  "location_id",    :limit => 255
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "opponent"
    t.integer  "score"
    t.integer  "opponent_score"
    t.integer  "season_id"
    t.string   "type",                          :default => "Event"
    t.string   "locality"
    t.datetime "end_date"
    t.boolean  "home"
  end

  create_table "events_users", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "guestnotes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note",       :limit => 255
    t.string   "author"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "messages", :force => true do |t|
    t.integer  "publisher_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject"
  end

  create_table "news", :force => true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer  "number"
    t.string   "position"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_since"
  end

  create_table "posts", :force => true do |t|
    t.text     "content"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_settings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.boolean  "comments_expanded", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", :force => true do |t|
    t.integer "game_id"
    t.integer "player_id"
    t.integer "goals",     :default => 0
    t.integer "assists",   :default => 0
  end

  create_table "seasons", :force => true do |t|
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_managers", :force => true do |t|
    t.boolean  "comments",      :default => true
    t.boolean  "news",          :default => true
    t.boolean  "forum",         :default => true
    t.boolean  "new_event",     :default => true
    t.boolean  "event_changed", :default => true
    t.integer  "user_id",       :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "user_pictures", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "hashed_password"
    t.string   "salt"
    t.boolean  "is_player",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "login"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "is_admin",        :default => false
    t.string   "phone"
    t.string   "mobile"
    t.string   "street"
    t.string   "number"
    t.string   "city"
    t.integer  "zip"
    t.string   "token"
    t.boolean  "is_chair_member", :default => false
  end

end
