class AddCompletedFlagToSituation < ActiveRecord::Migration
  def self.up
    add_column :situations, :completed, :boolean
  end

  def self.down
    remove_column :situations, :completed
  end
end
