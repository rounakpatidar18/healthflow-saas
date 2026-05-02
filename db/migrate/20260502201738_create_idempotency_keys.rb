class CreateIdempotencyKeys < ActiveRecord::Migration[8.1]
  def change
    create_table :idempotency_keys do |t|
      t.string :key
      t.jsonb :response
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
