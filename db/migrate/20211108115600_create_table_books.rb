class CreateTableBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :table_books do |t|
      t.string :year
      t.string :month
    end
  end
end
