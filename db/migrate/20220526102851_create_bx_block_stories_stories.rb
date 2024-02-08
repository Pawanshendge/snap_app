class CreateBxBlockStoriesStories < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_stories_stories do |t|
      t.text :description
      t.datetime :valid_for

      t.timestamps
    end
  end
end
