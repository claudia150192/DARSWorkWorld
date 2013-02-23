class AddInsertTypeColumnToTextResultsInserts < ActiveRecord::Migration
  def self.up
     add_column :text_result_inserts, :insert_type, :string
  end

  def self.down
    remove_column :text_result_inserts, :insert_type
  end
end
