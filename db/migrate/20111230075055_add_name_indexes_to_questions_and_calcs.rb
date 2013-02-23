class AddNameIndexesToQuestionsAndCalcs < ActiveRecord::Migration
  def self.up
    add_index :questions, :name
    add_index :web_calcs, :name
  end

  def self.down
    remove_index :questions, :name
    remove_index :web_calcs, :name
  end
end
