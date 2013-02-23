class CreateWebTextResultsTable < ActiveRecord::Migration
  def self.up
    create_table :web_text_results do |t|
      t.text    :text
      t.string  :reference_id
      t.string  :identifier
      t.text    :display_rules
      t.text    :comment
      t.float   :workbook_order

      t.timestamps
    end
  end

  def self.down
    drop_table :web_text_results
  end
  
end
