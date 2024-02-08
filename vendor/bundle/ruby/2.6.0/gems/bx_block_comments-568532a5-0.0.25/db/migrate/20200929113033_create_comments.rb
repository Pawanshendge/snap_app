# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :account, foreign_key: true
      t.bigint :commentable_id
      t.string :commentable_type
      t.text :comment
      t.timestamps
    end
  end
end
