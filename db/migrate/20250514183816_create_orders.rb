class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.decimal :total_amount, null: false

      t.timestamps
    end

    add_index :orders, :status
  end
end
