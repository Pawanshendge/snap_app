class CreateAdditionalPricePerPages < ActiveRecord::Migration[6.0]
  def change
    create_table :additional_price_per_pages do |t|
      t.integer :additional_price

      t.timestamps
    end
  end
end
