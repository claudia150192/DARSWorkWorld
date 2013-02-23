class CreateFederalPovertyLevels < ActiveRecord::Migration
  def self.up
    create_table :federal_poverty_levels do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.float :family_size_1
      t.float :family_size_2
      t.float :family_size_3
      t.float :family_size_4
      t.float :family_size_5
      t.float :family_size_6
      t.float :family_size_7
      t.float :family_size_8
      t.float :family_size_9
      t.float :family_size_10
      t.float :family_size_11
      t.float :family_size_12
      t.float :family_size_13
      t.float :family_size_14
      t.float :family_size_15
      t.float :additional

      t.timestamps
    end
  end

  def self.down
    drop_table :federal_poverty_levels
  end
end
