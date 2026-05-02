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

ActiveRecord::Schema[8.1].define(version: 2026_05_02_194028) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "appointment_time"
    t.datetime "created_at", null: false
    t.integer "doctor_id"
    t.integer "patient_id"
    t.integer "status"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id", "appointment_time"], name: "index_appointments_on_doctor_id_and_appointment_time"
    t.index ["tenant_id"], name: "index_appointments_on_tenant_id"
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "phone"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_patients_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "subdomain"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.integer "tenant_id"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "tenants"
  add_foreign_key "patients", "tenants"
end
