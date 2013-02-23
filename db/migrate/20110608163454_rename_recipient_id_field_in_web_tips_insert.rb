class RenameRecipientIdFieldInWebTipsInsert < ActiveRecord::Migration
  def self.up
     rename_column :web_tip_inserts, :recipient_id, :web_tip_id 
   end

   def self.down
     rename_column :web_tip_inserts, :web_tip_id, :recipient_id 
   end
end
