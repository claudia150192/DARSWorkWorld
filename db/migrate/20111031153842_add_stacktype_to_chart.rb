class AddStacktypeToChart < ActiveRecord::Migration
  def self.up
    add_column :charts, :stack_type, :string
  end

  def self.down
    remove_column :charts, :stack_type, :string
  end
end
