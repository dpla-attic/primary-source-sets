# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2016_03_16_201152) do

  # create_table "admins", force: :cascade do |t|
  #   t.string "email", default: "", null: false
  #   t.string "encrypted_password", default: "", null: false
  #   t.string "reset_password_token"
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.integer "sign_in_count", default: 0, null: false
  #   t.datetime "current_sign_in_at"
  #   t.datetime "last_sign_in_at"
  #   t.string "current_sign_in_ip"
  #   t.string "last_sign_in_ip"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.index ["email"], name: "index_admins_on_email", unique: true
  #   t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  # end

  create_table "attachments", force: :cascade do |t|
    t.integer "source_id"
    t.string "asset_type"
    t.integer "asset_id"
    t.index ["source_id", "asset_type", "asset_id"], name: "index_attachments_on_source_id_and_asset_type_and_asset_id"
    t.index ["source_id"], name: "index_attachments_on_source_id"
  end

  create_table "audios", force: :cascade do |t|
    t.string "file_base"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "meta"
    t.string "transcoding_job"
    t.index ["transcoding_job"], name: "index_audios_on_transcoding_job", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "affiliation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_guides", id: false, force: :cascade do |t|
    t.integer "guide_id"
    t.integer "author_id"
    t.index ["author_id"], name: "index_authors_guides_on_author_id"
    t.index ["guide_id"], name: "index_authors_guides_on_guide_id"
  end

  create_table "authors_source_sets", id: false, force: :cascade do |t|
    t.integer "source_set_id"
    t.integer "author_id"
    t.index ["author_id"], name: "index_authors_source_sets_on_author_id"
    t.index ["source_set_id"], name: "index_authors_source_sets_on_source_set_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "meta"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "guides", force: :cascade do |t|
    t.integer "source_set_id"
    t.string "name"
    t.text "questions", limit: 65535
    t.text "activity", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["source_set_id"], name: "index_guides_on_source_set_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "file_name"
    t.string "size"
    t.integer "height"
    t.integer "width"
    t.string "alt_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "meta"
  end

  create_table "source_sets", force: :cascade do |t|
    t.string "name"
    t.boolean "published", default: false
    t.text "description", limit: 65535
    t.text "overview", limit: 65535
    t.text "resources", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "year"
    t.datetime "published_at"
  end

  create_table "source_sets_tags", force: :cascade do |t|
    t.integer "source_set_id"
    t.integer "tag_id"
    t.index ["source_set_id"], name: "index_source_sets_tags_on_source_set_id"
    t.index ["tag_id"], name: "index_source_sets_tags_on_tag_id"
  end

  create_table "sources", force: :cascade do |t|
    t.integer "source_set_id"
    t.string "name"
    t.string "aggregation"
    t.text "textual_content", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "citation", limit: 65535
    t.text "credits", limit: 65535
    t.boolean "featured", default: false
    t.index ["source_set_id"], name: "index_sources_on_source_set_id"
  end

  create_table "tag_sequences", force: :cascade do |t|
    t.integer "vocabulary_id"
    t.integer "tag_id"
    t.integer "position"
    t.index ["tag_id"], name: "index_tag_sequences_on_tag_id"
    t.index ["vocabulary_id"], name: "index_tag_sequences_on_vocabulary_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "label"
    t.string "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "videos", force: :cascade do |t|
    t.string "file_base"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "meta"
    t.string "transcoding_job"
    t.index ["transcoding_job"], name: "index_videos_on_transcoding_job", unique: true
  end

  create_table "vocabularies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "filter"
  end

end
