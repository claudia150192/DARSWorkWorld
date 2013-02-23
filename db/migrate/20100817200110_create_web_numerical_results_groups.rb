class CreateWebNumericalResultsGroups < ActiveRecord::Migration
  def self.up
    create_table :web_numerical_results_groups do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end

  def self.down
    drop_table :web_numerical_results_groups
  end
end
