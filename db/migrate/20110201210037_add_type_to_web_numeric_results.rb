class AddTypeToWebNumericResults < ActiveRecord::Migration
  def self.up
    add_column :web_numerical_results, :result_type, :string
  end

  def self.down
    remove_column :web_numerical_results, :result_type
  end
end
