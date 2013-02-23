class UpdateWebTextResultsTableAddHelpId < ActiveRecord::Migration

  def self.up
       add_column :web_text_results, :help_id, :int
  end

  def self.down
      remove_column :web_text_results, :help_id
  end
 
  
end
