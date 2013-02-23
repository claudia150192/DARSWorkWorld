class AddGroupIdToWebTextResultsTable < ActiveRecord::Migration
  def self.up
    add_column :web_text_results, :group_id, :int
  end

  def self.down
    remove_column :web_text_results, :group_id
  end
end