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

ActiveRecord::Schema.define(:version => 20140303225630) do

  create_table "articles", :force => true do |t|
    t.string   "headline"
    t.text     "text"
    t.integer  "original_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "source"
    t.string   "link"
    t.integer  "trending_time"
    t.integer  "trending_id"
  end

  create_table "clients", :force => true do |t|
    t.string   "api_key"
    t.datetime "last_accessed"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "feeds", :force => true do |t|
    t.string   "url"
    t.string   "entries"
    t.string   "link"
    t.string   "headline"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.float    "same_source_threshold", :default => 0.1
    t.string   "xpath"
    t.string   "name"
  end

  create_table "trendings", :force => true do |t|
    t.integer  "article_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
