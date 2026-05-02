class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.references :patient, null: false, foreign_key: true
      t.decimal :amount
      t.integer :status
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
