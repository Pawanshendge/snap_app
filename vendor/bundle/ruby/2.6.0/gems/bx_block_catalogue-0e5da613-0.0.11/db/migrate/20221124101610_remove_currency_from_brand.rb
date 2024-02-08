class RemoveCurrencyFromBrand < ActiveRecord::Migration[6.0]
  def change
    remove_column :brands, :currency
  end
end
