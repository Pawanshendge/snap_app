class AddBlogFieldToStory < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_stories_stories, :title, :string
    add_column :bx_block_stories_stories, :link, :string
  end
end
