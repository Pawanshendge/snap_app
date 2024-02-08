class AddBookIdToPhoto < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :book_id, :integer
  end
end
