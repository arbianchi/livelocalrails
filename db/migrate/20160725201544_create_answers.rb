class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|

      t.integer :question_id
      t.integer :answerer_id
      t.integer :answerer_type
      t.string :answer_text

      t.timestamps
    end
  end
end
