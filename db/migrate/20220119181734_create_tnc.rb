class CreateTnc < ActiveRecord::Migration[6.0]
  def change
    create_table :tnc do |t|
      t.text :content
    end
  end
end
