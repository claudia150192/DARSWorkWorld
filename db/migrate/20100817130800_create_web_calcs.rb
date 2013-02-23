class CreateWebCalcs < ActiveRecord::Migration
  def self.up
    create_table :web_calcs do |t|
      t.string :name
      t.text :operation

      t.timestamps
    end
  end

  def self.down
    drop_table :web_calcs
  end
end
