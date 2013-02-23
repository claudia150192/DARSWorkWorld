class CreateMedicaidAnnualBlindThresholds < ActiveRecord::Migration
  def self.up
    create_table :medicaid_annual_blind_thresholds do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.float :alabama
      t.float :alaska
      t.float :arizona
      t.float :arkansas
      t.float :california
      t.float :colorado	
      t.float :connecticut
      t.float :delaware
      t.float :district_of_columbia
      t.float :florida	
      t.float :georgia	
      t.float :hawaii
      t.float :idaho
      t.float :illinois
      t.float :indiana
      t.float :iowa
      t.float :kansas
      t.float :kentucky
      t.float :louisiana
      t.float :maine
      t.float :maryland
      t.float :massachusetts
      t.float :michigan
      t.float :minnesota
      t.float :mississippi
      t.float :missouri
      t.float :montana
      t.float :nebraska
      t.float :nevada
      t.float :new_hampshire
      t.float :new_jersey
      t.float :new_mexico
      t.float :new_york
      t.float :north_carolina
      t.float :north_dakota
      t.float :ohio
      t.float :oklahoma
      t.float :oregon
      t.float :pennsylvania
      t.float :rhode_island
      t.float :south_carolina
      t.float :south_dakota
      t.float :tennessee
      t.float :texas
      t.float :utah
      t.float :vermont
      t.float :virginia
      t.float :washington
      t.float :west_virginia
      t.float :wisconsin
      t.float :wyoming

      t.timestamps
    end
  end

  def self.down
    drop_table :medicaid_annual_blind_thresholds
  end
end
