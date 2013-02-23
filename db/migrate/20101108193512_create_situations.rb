class CreateSituations < ActiveRecord::Migration
  def self.up
    create_table :situations do |t|
      t.string :situation_type
      t.string :mode, :default => "one_at_a_time"
      t.integer :case_id

      t.timestamps
    end
  end

  def self.down
    drop_table :situations
  end
end
