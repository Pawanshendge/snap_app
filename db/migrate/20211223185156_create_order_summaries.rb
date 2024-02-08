class CreateOrderSummaries < ActiveRecord::Migration[6.0]
  def change
    create_table :order_summaries do |t|
      t.integer :quantity
      t.string :gift_note
      t.string :discount_code
      t.integer :order_subtotal
      t.integer :book_id
      t.integer :delivery_charge
      t.string :book_size
      t.string :cover_type
      t.integer :order_total
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
