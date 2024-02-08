class AddUserIdToContributionImage < ActiveRecord::Migration[6.0]
  def change
    add_column :contribution_images, :user_id, :integer
  end
end
