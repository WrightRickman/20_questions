class CreateQuestionTrees < ActiveRecord::Migration
  def change
    create_table :question_trees do |t|
      t.string :message
      t.integer :yes_id
      t.integer :no_id

      t.timestamps
    end
  end
end
