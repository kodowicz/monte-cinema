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

ActiveRecord::Schema.define(version: 2021_06_12_205148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cinema_halls", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "seats", default: [], array: true
    t.text "not_available", default: [], array: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "age"
    t.boolean "real_user"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "display_types", force: :cascade do |t|
    t.string "name", default: "2D"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.integer "duration"
    t.integer "age_restriction", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description", default: ""
    t.text "poster", default: ""
    t.text "trailer", default: ""
    t.text "direction", default: ""
    t.text "production", default: ""
    t.integer "ratio", default: 0
    t.datetime "release_at"
    t.bigint "genre_id"
    t.index ["genre_id"], name: "index_movies_on_genre_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "ticket_desk_id", null: false
    t.bigint "client_id", null: false
    t.bigint "screening_id", null: false
    t.datetime "expires_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["screening_id"], name: "index_reservations_on_screening_id"
    t.index ["ticket_desk_id"], name: "index_reservations_on_ticket_desk_id"
  end

  create_table "screenings", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.bigint "cinema_hall_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "display_type_id", null: false
    t.bigint "voice_type_id", null: false
    t.index ["cinema_hall_id"], name: "index_screenings_on_cinema_hall_id"
    t.index ["display_type_id"], name: "index_screenings_on_display_type_id"
    t.index ["movie_id"], name: "index_screenings_on_movie_id"
    t.index ["voice_type_id"], name: "index_screenings_on_voice_type_id"
  end

  create_table "ticket_desks", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "online"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "seat"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reservation_id", null: false
    t.integer "ticket_type", default: 0, null: false
    t.index ["reservation_id"], name: "index_tickets_on_reservation_id"
  end

  create_table "voice_types", force: :cascade do |t|
    t.string "name", default: "original"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "movies", "genres"
  add_foreign_key "reservations", "clients"
  add_foreign_key "reservations", "screenings"
  add_foreign_key "reservations", "ticket_desks"
  add_foreign_key "screenings", "cinema_halls"
  add_foreign_key "screenings", "display_types"
  add_foreign_key "screenings", "movies"
  add_foreign_key "screenings", "voice_types"
  add_foreign_key "tickets", "reservations"
end
