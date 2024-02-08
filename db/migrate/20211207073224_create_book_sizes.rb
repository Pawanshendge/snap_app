class CreateBookSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :book_sizes do |t|
      t.string :book_size

      t.timestamps
    end
  end
end
