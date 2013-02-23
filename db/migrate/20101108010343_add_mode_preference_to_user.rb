class AddModePreferenceToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :mode_preference, :string
  end

  def self.down
    remove_column :users, :mode_preference
  end
end
