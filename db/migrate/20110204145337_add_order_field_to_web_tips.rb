class AddOrderFieldToWebTips < ActiveRecord::Migration
  def self.up
    add_column :web_tips, :order, :integer
  end

  def self.down
    remove_column :web_tips, :order
  end
end
