class CreateBxBlockStoriesBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_stories_blogs do |t|
      t.string :title
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
