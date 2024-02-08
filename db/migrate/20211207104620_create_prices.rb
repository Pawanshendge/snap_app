class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.string :cover_type
      t.float :price

      t.timestamps
    end
  end
end
