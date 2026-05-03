class CreateInventoryItems < ActiveRecord::Migration[8.1]
  def change
    create_table :inventory_items do |t|
      t.references :medicine, null: false, foreign_key: true
      t.integer :quantity
      t.date :expiry_date
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
