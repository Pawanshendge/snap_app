class CreateQuestionSubTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :question_sub_types do |t|
      t.string :sub_type
      t.text :description
      t.references :question_type, foreign_key: true
      t.timestamps
    end
  end
end
