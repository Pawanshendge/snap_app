class CreatePrivacyPolicy < ActiveRecord::Migration[6.0]
  def change
    create_table :privacy_policy do |t|
      t.text :content
    end
  end
end
