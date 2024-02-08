class AddCurrencyToBrandAsEnum < ActiveRecord::Migration[6.0]
  def change
    add_column :brands, :currency, :integer, default: 0
  end
end
