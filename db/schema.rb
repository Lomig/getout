# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_03_095913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "color_hex"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "place_id", null: false
    t.boolean "liked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["place_id"], name: "index_likes_on_place_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "place_genres", force: :cascade do |t|
    t.float "broadcasting_percentage"
    t.bigint "place_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_place_genres_on_genre_id"
    t.index ["place_id"], name: "index_place_genres_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "category"
    t.text "description"
    t.time "opening_start"
    t.time "opening_end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "avg_rating"
  end

  create_table "sub_genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "genre_id"
    t.index ["genre_id"], name: "index_sub_genres_on_genre_id"
  end

  create_table "user_artist_genres", force: :cascade do |t|
    t.bigint "user_artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sub_genre_id"
    t.index ["sub_genre_id"], name: "index_user_artist_genres_on_sub_genre_id"
    t.index ["user_artist_id"], name: "index_user_artist_genres_on_user_artist_id"
  end

  create_table "user_artists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_artists_on_user_id"
  end

  create_table "user_genres", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "genre_id", null: false
    t.float "listening_percentage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_user_genres_on_genre_id"
    t.index ["user_id"], name: "index_user_genres_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.string "provider"
    t.string "uid"
    t.boolean "viewed_tastes_screen"
    t.string "access_token"
    t.string "refresh_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "likes", "places"
  add_foreign_key "likes", "users"
  add_foreign_key "place_genres", "genres"
  add_foreign_key "place_genres", "places"
  add_foreign_key "sub_genres", "genres"
  add_foreign_key "user_artist_genres", "sub_genres"
  add_foreign_key "user_artist_genres", "user_artists"
  add_foreign_key "user_artists", "users"
  add_foreign_key "user_genres", "genres"
  add_foreign_key "user_genres", "users"
end
