class AddNotesToCases < ActiveRecord::Migration
  def self.up
    add_column :cases, :notes, :text
  end

  def self.down
    remove_column :cases, :notes
  end
end
