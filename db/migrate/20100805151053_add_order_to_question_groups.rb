class AddOrderToQuestionGroups < ActiveRecord::Migration
  def self.up
    add_column :question_groups, :order, :integer
  end

  def self.down
    remove_column :question_groups, :order
  end
end
