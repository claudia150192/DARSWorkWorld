class RenameReferenceIdInQuestionGroupsTableToWorkbookOrder < ActiveRecord::Migration
  def self.up
    rename_column :question_groups, :reference_id, :workbook_order
  end

  def self.down
     rename_column :question_groups, :workbook_order, :reference_id
  end
end