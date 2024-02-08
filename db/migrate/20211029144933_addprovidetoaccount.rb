class Addprovidetoaccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :provider, :string
  end
end
