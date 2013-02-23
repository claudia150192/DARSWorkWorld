class ModifyWebtipsChangeOrderToGroupOrder < ActiveRecord::Migration
  def self.up
    rename_column :web_tips, :order, :group_order
  end

  def self.down
    rename_column :web_tips, :group_order, :order
  end
end
