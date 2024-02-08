class AddStoryTypeToStory < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_stories_stories, :story_type, :integer, default: 0
  end
end
