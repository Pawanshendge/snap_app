class AddColumnSharedLinkinContributions < ActiveRecord::Migration[6.0]
  def change
    add_column :contributions, :shared_link, :string
  end
end
