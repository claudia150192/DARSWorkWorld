class AddActiveFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :active, :boolean, :default => false, :null => false
    User.all.each do |user|
      #anyone on now should be active
      user.active=true
      user.save!
    end
  end

  def self.down
    remove_column :users, :active
  end
end
