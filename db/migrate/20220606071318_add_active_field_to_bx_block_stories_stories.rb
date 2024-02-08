class AddActiveFieldToBxBlockStoriesStories < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_stories_stories, :active, :boolean, default: false
  end
end
