class CreatePrescriptionItems < ActiveRecord::Migration[8.1]
  def change
    create_table :prescription_items do |t|
      t.references :prescription, null: false, foreign_key: true
      t.references :medicine, null: false, foreign_key: true
      t.string :dosage
      t.integer :quantity
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
