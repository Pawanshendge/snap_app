class CreateBookColors < ActiveRecord::Migration[6.0]
  def change
    create_table :book_colors do |t|
      t.string :book_color

      t.timestamps
    end
  end
end
