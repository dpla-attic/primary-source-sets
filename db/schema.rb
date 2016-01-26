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

ActiveRecord::Schema.define(version: 20160114144803) do

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "attachments", force: true do |t|
    t.integer "source_id"
    t.integer "asset_id"
    t.string  "asset_type"
  end

  add_index "attachments", ["source_id", "asset_type", "asset_id"], name: "index_attachments_on_source_id_and_asset_type_and_asset_id"
  add_index "attachments", ["source_id"], name: "index_attachments_on_source_id"

  create_table "audios", force: true do |t|
    t.string   "file_base"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "meta"
    t.string   "transcoding_job"
  end

  add_index "audios", ["transcoding_job"], name: "index_audios_on_transcoding_job", unique: true

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

  create_table "documents", force: true do |t|
    t.string   "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "meta"
  end

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

  create_table "images", force: true do |t|
    t.string   "file_name"
    t.string   "size"
    t.string   "alt_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "meta"
  end

  create_table "source_sets", force: true do |t|
    t.string   "name"
    t.boolean  "published",                 default: false
    t.text     "description", limit: 65535
    t.text     "overview",    limit: 65535
    t.text     "resources",   limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "slug"
    t.integer  "year"
  end

  create_table "source_sets_tags", force: true do |t|
    t.integer "source_set_id"
    t.integer "tag_id"
  end

  add_index "source_sets_tags", ["source_set_id"], name: "index_source_sets_tags_on_source_set_id"
  add_index "source_sets_tags", ["tag_id"], name: "index_source_sets_tags_on_tag_id"

  create_table "sources", force: true do |t|
    t.integer  "source_set_id"
    t.string   "name"
    t.string   "aggregation"
    t.text     "textual_content", limit: 16777215
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.text     "citation",        limit: 65535
    t.text     "credits",         limit: 65535
    t.boolean  "featured",                         default: false
  end

  add_index "sources", ["source_set_id"], name: "index_sources_on_source_set_id"

  create_table "tags", force: true do |t|
    t.string   "label"
    t.string   "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "tags_vocabularies", force: true do |t|
    t.integer "vocabulary_id"
    t.integer "tag_id"
  end

  add_index "tags_vocabularies", ["tag_id"], name: "index_tags_vocabularies_on_tag_id"
  add_index "tags_vocabularies", ["vocabulary_id"], name: "index_tags_vocabularies_on_vocabulary_id"

  create_table "videos", force: true do |t|
    t.string   "file_base"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "meta"
    t.string   "transcoding_job"
  end

  add_index "videos", ["transcoding_job"], name: "index_videos_on_transcoding_job", unique: true

  create_table "vocabularies", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.boolean  "filter"
  end

end
