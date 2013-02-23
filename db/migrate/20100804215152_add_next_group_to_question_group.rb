class AddNextGroupToQuestionGroup < ActiveRecord::Migration
  def self.up
    add_column :question_groups, :next_group_id, :integer
  end

  def self.down
     remove_column :question_groups, :next_group_id
  end
end
