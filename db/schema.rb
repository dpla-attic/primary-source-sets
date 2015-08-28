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

ActiveRecord::Schema.define(version: 20150829151317) do

  create_table "authors", force: true do |t|
    t.string   "name"
    t.string   "affiliation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "authors_guides", id: false, force: true do |t|
    t.integer "guide_id"
    t.integer "author_id"
  end

  add_index "authors_guides", ["author_id"], name: "index_authors_guides_on_author_id"
  add_index "authors_guides", ["guide_id"], name: "index_authors_guides_on_guide_id"

  create_table "authors_source_sets", id: false, force: true do |t|
    t.integer "source_set_id"
    t.integer "author_id"
  end

  add_index "authors_source_sets", ["author_id"], name: "index_authors_source_sets_on_author_id"
  add_index "authors_source_sets", ["source_set_id"], name: "index_authors_source_sets_on_source_set_id"

  create_table "guides", force: true do |t|
    t.integer  "source_set_id"
    t.string   "name"
    t.text     "questions",     limit: 65535
    t.text     "activity",      limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "guides", ["source_set_id"], name: "index_guides_on_source_set_id"

  create_table "source_sets", force: true do |t|
    t.string   "name"
    t.boolean  "published",                 default: false
    t.text     "description", limit: 65535
    t.text     "overview",    limit: 65535
    t.text     "resources",   limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "sources", force: true do |t|
    t.integer  "source_set_id"
    t.string   "name"
    t.string   "aggregation"
    t.string   "media_type"
    t.text     "textual_content", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "sources", ["source_set_id"], name: "index_sources_on_source_set_id"

end
