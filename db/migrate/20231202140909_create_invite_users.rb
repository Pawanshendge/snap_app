class CreateInviteUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :invite_users do |t|
      t.string :name
      t.string :email
      t.integer :status
      t.string :sharable_link
      t.string :unique_identify_id
      t.references :account, foreign_key: true
      t.references :table_books, foreign_key: true
    end
  end
end
