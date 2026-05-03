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

ActiveRecord::Schema[8.1].define(version: 2026_05_03_122035) do
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
    t.index ["appointment_time"], name: "index_appointments_on_appointment_time"
    t.index ["doctor_id", "appointment_time"], name: "index_appointments_on_doctor_id_and_appointment_time"
    t.index ["tenant_id"], name: "index_appointments_on_tenant_id"
  end

  create_table "idempotency_keys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "key"
    t.jsonb "response"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_idempotency_keys_on_tenant_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "expiry_date"
    t.bigint "medicine_id", null: false
    t.integer "quantity"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["medicine_id"], name: "index_inventory_items_on_medicine_id"
    t.index ["tenant_id"], name: "index_inventory_items_on_tenant_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.bigint "patient_id", null: false
    t.integer "status"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_invoices_on_created_at"
    t.index ["patient_id"], name: "index_invoices_on_patient_id"
    t.index ["tenant_id"], name: "index_invoices_on_tenant_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_medicines_on_tenant_id"
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "phone"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_patients_on_tenant_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.string "idempotency_key"
    t.bigint "invoice_id", null: false
    t.integer "status"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["idempotency_key"], name: "index_payments_on_idempotency_key", unique: true
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
    t.index ["tenant_id"], name: "index_payments_on_tenant_id"
  end

  create_table "prescription_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "dosage"
    t.bigint "medicine_id", null: false
    t.bigint "prescription_id", null: false
    t.integer "quantity"
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["medicine_id"], name: "index_prescription_items_on_medicine_id"
    t.index ["prescription_id"], name: "index_prescription_items_on_prescription_id"
    t.index ["tenant_id"], name: "index_prescription_items_on_tenant_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "doctor_id"
    t.bigint "patient_id", null: false
    t.bigint "tenant_id", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_prescriptions_on_patient_id"
    t.index ["tenant_id"], name: "index_prescriptions_on_tenant_id"
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
  add_foreign_key "idempotency_keys", "tenants"
  add_foreign_key "inventory_items", "medicines"
  add_foreign_key "inventory_items", "tenants"
  add_foreign_key "invoices", "patients"
  add_foreign_key "invoices", "tenants"
  add_foreign_key "medicines", "tenants"
  add_foreign_key "patients", "tenants"
  add_foreign_key "payments", "invoices"
  add_foreign_key "payments", "tenants"
  add_foreign_key "prescription_items", "medicines"
  add_foreign_key "prescription_items", "prescriptions"
  add_foreign_key "prescription_items", "tenants"
  add_foreign_key "prescriptions", "patients"
  add_foreign_key "prescriptions", "tenants"
end
