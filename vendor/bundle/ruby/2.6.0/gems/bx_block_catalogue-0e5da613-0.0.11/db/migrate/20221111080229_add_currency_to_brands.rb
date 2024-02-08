class AddCurrencyToBrands < ActiveRecord::Migration[6.0]
  def change
    add_column :brands, :currency, :string
  end
end
