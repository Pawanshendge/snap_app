class CreateDraftMailTimer < ActiveRecord::Migration[6.0]
  def change
    create_table :draft_mail_timers do |t|
      t.integer :first_mail_in_minuts
      t.integer :second_mail_in_days

      t.timestamps
    end
  end
end
