class AddTypeAndOrderToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :question_type, :string
    add_column :questions, :answer_choices, :text
    add_column :questions, :order, :integer
  end

  def self.down
    remove_column :questions, :question_type
    remove_column :questions, :answer_choices
    remove_column :questions, :order
  end
end
