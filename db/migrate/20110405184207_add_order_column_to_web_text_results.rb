class AddOrderColumnToWebTextResults < ActiveRecord::Migration
  def self.up
    add_column :web_text_results, :order, :int
  end

  def self.down
     remove_column :web_text_results, :order
  end
end
