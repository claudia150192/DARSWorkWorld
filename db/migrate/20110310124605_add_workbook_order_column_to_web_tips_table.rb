class AddWorkbookOrderColumnToWebTipsTable < ActiveRecord::Migration
  def self.up
    add_column :web_tips, :workbook_order, :float
  end

  def self.down
    remove_column :web_tips, :workbook_order
  end
end
