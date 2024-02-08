class CreateRnrPolicy < ActiveRecord::Migration[6.0]
  def change
    create_table :rnr_policy do |t|
      t.text :content
    end
  end
end
