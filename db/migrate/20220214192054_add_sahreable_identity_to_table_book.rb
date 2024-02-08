class AddSahreableIdentityToTableBook < ActiveRecord::Migration[6.0]
  def change
    add_column :table_books, :shareable_identity, :string
  end
end
