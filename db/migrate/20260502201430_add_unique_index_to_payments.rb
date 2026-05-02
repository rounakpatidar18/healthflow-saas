class AddUniqueIndexToPayments < ActiveRecord::Migration[8.1]
  def change
    add_index :payments, :idempotency_key, unique: true
  end
end
