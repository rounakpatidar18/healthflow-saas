class AddIndexToAppointments < ActiveRecord::Migration[8.1]
  def change
    add_index :appointments, [ :doctor_id, :appointment_time ]
    add_index :appointments, :tenant_id, if_not_exists: true
  end
end
