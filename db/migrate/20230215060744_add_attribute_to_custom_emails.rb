class AddAttributeToCustomEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :custom_emails, :phone_no, :string
    add_column :custom_emails, :email, :string
    add_column :custom_emails, :timing_of_service, :string
  end
end
