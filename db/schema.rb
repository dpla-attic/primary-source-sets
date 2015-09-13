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

ActiveRecord::Schema.define(version: 20150914012241) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

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

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "guides", force: true do |t|
    t.integer  "source_set_id"
    t.string   "name"
    t.text     "questions",     limit: 65535
    t.text     "activity",      limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "slug"
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
    t.string   "slug"
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
