class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :starting_address
      t.string :status
      t.integer :total_price_cents
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
