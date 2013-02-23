class AddInsertTypeColumnToWebTipInserts < ActiveRecord::Migration
  def self.up
     add_column :web_tip_inserts, :insert_type, :string
  end

  def self.down
    remove_column :web_tip_inserts, :insert_type
  end
end
