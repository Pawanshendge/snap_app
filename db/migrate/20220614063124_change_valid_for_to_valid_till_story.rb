class ChangeValidForToValidTillStory < ActiveRecord::Migration[6.0]
  def change
    rename_column :bx_block_stories_stories, :valid_for, :valid_till
  end
end
