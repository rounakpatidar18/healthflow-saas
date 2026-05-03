class AddIndexesForReports < ActiveRecord::Migration[8.1]
  def change
    add_index :invoices, :created_at
    add_index :appointments, :appointment_time
    add_index :prescription_items, :medicine_id, if_not_exists: true
  end
end
