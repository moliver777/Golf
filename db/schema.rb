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

ActiveRecord::Schema.define(:version => 20140613151824) do

  create_table "pros", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "score",      :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "image"
  end

  create_table "site_settings", :force => true do |t|
    t.string   "config_key",   :default => "", :null => false
    t.string   "config_value",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "amateur_1",                                                           :null => false
    t.integer  "score",                            :default => 0,                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "image",      :limit => 2147483647
    t.string   "amateur_2"
    t.string   "amateur_3"
    t.integer  "pro_id"
    t.time     "tee_time",                         :default => '2000-01-01 00:00:00', :null => false
  end

end
