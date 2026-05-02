class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :invoice, null: false, foreign_key: true
      t.decimal :amount
      t.integer :status
      t.string :idempotency_key
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
