class AddNumericalResultToWebTips < ActiveRecord::Migration
  def self.up
    add_column :web_tips, :web_numerical_result_id, :integer
  end

  def self.down
    remove_column :web_tips, :web_numerical_result_id
  end
end
