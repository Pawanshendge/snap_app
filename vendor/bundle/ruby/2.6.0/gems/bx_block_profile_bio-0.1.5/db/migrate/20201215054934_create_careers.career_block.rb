# frozen_string_literal: true

class CreateCareers < ActiveRecord::Migration[6.0]
  def change
    create_table :careers do |t|
      t.string :profession
      t.boolean :is_current, default: false
      t.string :experience_from
      t.string :experience_to
      t.string :payscale
      t.string :company_name
      t.string :accomplishment, array: true
      t.integer :sector
      t.integer :profile_bio_id

      t.timestamps
    end
  end
end
