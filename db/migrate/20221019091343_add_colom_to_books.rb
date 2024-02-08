class AddColomToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :book_status, :integer
    add_column :table_books, :created_at, :datetime
    add_column :table_books, :updated_at, :datetime
    change_column_default :table_books, :created_at, from: nil, to: ->{ 'current_timestamp' }
    change_column_default :table_books, :updated_at, from: nil, to: ->{ 'current_timestamp' }
  end
end
