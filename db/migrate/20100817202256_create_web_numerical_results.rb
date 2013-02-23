class CreateWebNumericalResults < ActiveRecord::Migration
  def self.up
    create_table :web_numerical_results do |t|
      t.string :name
      t.text :display_rules
      t.integer :order
      t.integer :web_calc_id
      t.integer :group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :web_numerical_results
  end
end
