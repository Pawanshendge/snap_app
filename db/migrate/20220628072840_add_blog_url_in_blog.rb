class AddBlogUrlInBlog < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_stories_blogs, :url, :string
  end
end
