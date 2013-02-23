class AddHelpIdToNumericResults < ActiveRecord::Migration
  def self.up
    add_column :web_numerical_results, :help_id, :integer
  end

  def self.down
    remove_column :web_numerical_results, :help_id, :integer
  end
end
