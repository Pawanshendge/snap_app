class CreateQuestionAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :question_answers do |t|
      t.string :question
      t.text :answer
      t.references :question_sub_type, foreign_key: true
      t.timestamps
    end
  end
end
