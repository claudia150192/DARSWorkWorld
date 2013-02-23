class ChangeValidationToBeATextField < ActiveRecord::Migration
  def self.up
    change_column :questions, :validation_message, :text
  end

  def self.down
    change_column :questions, :validation_message, :string
  end
end
