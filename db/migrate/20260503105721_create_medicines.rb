class CreateMedicines < ActiveRecord::Migration[8.1]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :description
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
