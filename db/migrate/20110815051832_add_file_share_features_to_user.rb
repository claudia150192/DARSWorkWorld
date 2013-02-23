class AddFileShareFeaturesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :allow_fileshare, :boolean, :default=>false
    add_column :users, :receive_fileshare, :boolean, :default=>false
    add_column :users, :receive_share_email, :boolean, :default=>false
  end

  def self.down
    remove_column :users, :allow_fileshare, :boolean, :default=>false
    remove_column :users, :receive_fileshare, :boolean, :default=>false
    remove_column :users, :receive_share_email, :boolean, :default=>false

  end
end
