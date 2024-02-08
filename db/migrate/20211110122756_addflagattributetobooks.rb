class Addflagattributetobooks < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :flag, :boolean, :null => false, :default => false
  end
end
