class RenameRecipientIdFieldInTextResultsInsert < ActiveRecord::Migration
  def self.up
    rename_column :text_result_inserts, :recipient_id, :web_text_result_id 
  end

  def self.down
    rename_column :text_result_inserts, :web_text_result_id, :recipient_id 
  end
end
