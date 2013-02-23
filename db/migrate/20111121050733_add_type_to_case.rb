class AddTypeToCase < ActiveRecord::Migration
  def self.up
    add_column :cases, :type, :string
  end

  def self.down
    remove_column :cases, :type
  end
end
