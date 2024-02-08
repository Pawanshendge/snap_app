class CreateContributions < ActiveRecord::Migration[6.0]
  def change
    create_table :contributions do |t|
      t.integer :user_id
      t.integer :friend_id
      t.datetime :shared_datetime
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
