class AddValidationRulesToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :validation_rules, :text
    add_column :questions, :validation_message, :string
  end

  def self.down
    remove_column :questions, :validation_rules
    remove_column :questions, :validation_message
  end
end
