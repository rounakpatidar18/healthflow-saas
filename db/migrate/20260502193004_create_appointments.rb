class CreateAppointments < ActiveRecord::Migration[8.1]
  def change
    create_table :appointments do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.datetime :appointment_time
      t.integer :status
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
