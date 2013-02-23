class AddParentToSituation < ActiveRecord::Migration
  def self.up
    add_column :situations, :parent_id, :integer
  end

  def self.down
    remove_column :situations, :parent_id
  end
end
