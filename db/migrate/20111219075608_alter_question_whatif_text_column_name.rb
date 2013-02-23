class AlterQuestionWhatifTextColumnName < ActiveRecord::Migration
  def self.up
    rename_column :questions, :what_if_text, :all_inputs_text
  end

  def self.down
    rename_column :questions, :all_inputs_text, :what_if_text
  end
end
