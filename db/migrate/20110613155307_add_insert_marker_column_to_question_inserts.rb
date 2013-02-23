class AddInsertMarkerColumnToQuestionInserts < ActiveRecord::Migration
  def self.up
    add_column :question_inserts, :insert_marker, :string
  end

  def self.down
    remove_column :question_inserts, :insert_marker
  end
end
