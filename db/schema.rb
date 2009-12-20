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

ActiveRecord::Schema.define(:version => 20091220225418) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "number"
    t.string   "city"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

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
    t.string   "type"
  end

  create_table "events_users", :force => true do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  create_table "games", :force => true do |t|
    t.datetime "date"
    t.integer  "location_id"
    t.string   "opponent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id"
    t.integer  "score"
    t.integer  "opponent_score"
  end

  create_table "games_players", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "player_id"
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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "classification"
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

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

end
