class AddParentIdColumnToQuestionTreesTable < ActiveRecord::Migration
  def up
  	add_column :question_trees, :parent_id, :integer
  end

  def down
  	remove_column :question_trees, :parent_id
  end
end
