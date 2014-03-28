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

ActiveRecord::Schema.define(version: 20140328175042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hashtag_tweets", force: true do |t|
    t.integer  "tweet_id"
    t.integer  "hashtag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hashtags", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hashtags", ["text"], name: "index_hashtags_on_text", using: :btree

  create_table "link_tweets", force: true do |t|
    t.integer  "tweet_id"
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["text"], name: "index_links_on_text", using: :btree

  create_table "mention_tweets", force: true do |t|
    t.integer  "tweet_id"
    t.integer  "mention_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentions", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mentions", ["text"], name: "index_mentions_on_text", using: :btree

  create_table "scans", force: true do |t|
    t.string   "username"
    t.integer  "score"
    t.string   "error"
    t.integer  "user_id"
    t.float    "average_sentiment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.text     "text"
    t.string   "twitter_id"
    t.datetime "tweet_time"
    t.integer  "score"
    t.integer  "scan_id"
    t.float    "sentiment_score"
    t.string   "sentiment_summary"
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_geo"
    t.float    "lat"
    t.float    "lng"
  end

  add_index "tweets", ["scan_id"], name: "index_tweets_on_scan_id", using: :btree
  add_index "tweets", ["twitter_id"], name: "index_tweets_on_twitter_id", using: :btree

  create_table "twitter_details", force: true do |t|
    t.string   "oauth_token_secret"
    t.string   "oauth_token"
    t.datetime "account_created_at"
    t.string   "description"
    t.integer  "favorites_count"
    t.integer  "followers_count"
    t.integer  "following_count"
    t.string   "location"
    t.string   "name"
    t.string   "user_name"
    t.string   "background_image_url"
    t.string   "profile_image_url"
    t.integer  "total_tweets"
    t.string   "website_url"
    t.string   "twitter_url"
    t.string   "twitter_uid"
    t.integer  "user_id"
    t.integer  "scan_id"
    t.boolean  "protected_tweets"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "word_tweets", force: true do |t|
    t.integer  "word_id"
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "word_tweets", ["tweet_id"], name: "index_word_tweets_on_tweet_id", using: :btree
  add_index "word_tweets", ["word_id"], name: "index_word_tweets_on_word_id", using: :btree

  create_table "words", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
