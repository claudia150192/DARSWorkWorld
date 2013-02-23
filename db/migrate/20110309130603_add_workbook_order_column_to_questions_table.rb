class AddWorkbookOrderColumnToQuestionsTable < ActiveRecord::Migration
  def self.up
    add_column :questions, :workbook_order, :float
  end

  def self.down
    remove_column :questions, :workbook_order
  end
end
