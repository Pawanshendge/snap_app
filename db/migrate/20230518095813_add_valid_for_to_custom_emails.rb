class AddValidForToCustomEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :custom_emails, :valid_for, :integer
  end
end
