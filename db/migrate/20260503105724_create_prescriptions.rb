class CreatePrescriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :prescriptions do |t|
      t.references :patient, null: false, foreign_key: true
      t.integer :doctor_id
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
