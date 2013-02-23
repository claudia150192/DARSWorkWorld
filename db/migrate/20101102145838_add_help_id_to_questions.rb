class AddHelpIdToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :help_id, :integer
  end

  def self.down
    remove_column :questions, :help_id
  end
end
