class AddRefernceIdToQuestionGroups < ActiveRecord::Migration
  def self.up
    add_column :question_groups, :reference_id, :float
  end

  def self.down
    remove_column :question_groups, :reference_id
  end
end
