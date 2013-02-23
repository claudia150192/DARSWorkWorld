class AddParentIdToQuestionGroup < ActiveRecord::Migration
  def self.up
    add_column :question_groups, :parent_id, :integer
  end

  def self.down
    rempve_column :question_groups, :parent_id
  end
end
