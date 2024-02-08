class AddColumnToPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :prices, :min_limit, :integer
    add_column :prices, :max_limit, :integer
    add_column :prices, :book_size, :string
  end
end
