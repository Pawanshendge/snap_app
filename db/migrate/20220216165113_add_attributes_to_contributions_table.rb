class AddAttributesToContributionsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :contributions, :image_id, :integer
    add_column :contributions, :service_url, :string
    add_column :contributions, :unique_identify_id, :string
  end
end

