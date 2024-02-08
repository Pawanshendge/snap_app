class CreateDashboardMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboard_media_files do |t|
      t.string :name
      t.integer :priority

      t.timestamps
    end
  end
end
