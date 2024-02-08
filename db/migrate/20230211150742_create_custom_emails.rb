class CreateCustomEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_emails do |t|
      t.string :description
      t.string :title
      t.string :address
      t.integer :email_type
    end
  end
end
