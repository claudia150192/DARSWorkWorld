class UpdateUserTableAddCounselorName < ActiveRecord::Migration
  def self.up
       add_column :users, :counselor_name, :string
  end

  def self.down
      remove_column :users, :counselor_name
  end
end