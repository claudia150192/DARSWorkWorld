class AddForceDefaultToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :force_default, :boolean
  end

  def self.down
    remove_column :questions, :force_default
  end
end
