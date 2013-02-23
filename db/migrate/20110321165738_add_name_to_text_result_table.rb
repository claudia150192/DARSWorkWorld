class AddNameToTextResultTable < ActiveRecord::Migration
  def self.up
    add_column :web_text_results, :name, :string
  end

  def self.down
    remove_column :web_text_results, :name
  end
end
