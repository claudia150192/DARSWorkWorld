class AddTextToWebNumericalResults < ActiveRecord::Migration
  def self.up
    add_column :web_numerical_results, :text, :string
  end

  def self.down
    remove_column :web_numerical_results, :text
  end
end
