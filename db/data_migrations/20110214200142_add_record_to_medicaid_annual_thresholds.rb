class AddRecordToMedicaidAnnualThresholds < ActiveRecord::Migration
  def self.up
    
    MedicaidAnnualThreshold.create!(:start_date => Date.new(2011,01,01), 
                        :end_date => Date.new(2011,12,31),
                        :alabama => 24438.00,
                        :alaska => 51525.00,
                        :arizona	=> 30870.00,
                        :arkansas	=> 28730.00,
                        :california	=> 35023.00,
                        :colorado	=> 31990.00,
                        :connecticut => 56502.00,
                        :delaware	=> 38668.00,
                        :district_of_columbia	=> 43037.00,
                        :florida	=> 28753.00,
                        :georgia	=>27509.00,
                        :hawaii	=> 36977.00,
                        :idaho	=> 38495.00,
                        :illinois	=> 26141.00,
                        :indiana	=> 34713.00,
                        :iowa	=> 30811.00,
                        :kansas	=>	34071.00,
                        :kentucky	=> 27345.00,
                        :louisiana	=> 29763.00,
                        :maine	=>	32403.00,
                        :maryland	=>	38660.00,
                        :massachusetts	=>	36391.00,
                        :michigan	=>	29036.00,
                        :minnesota	=>	49550.00,
                        :mississippi	=>	25923.00,
                        :missouri	=>	31180.00,
                        :montana	=>	29429.00,
                        :nebraska	=> 36295.00,
                        :nevada	=> 30135.00,
                        :new_hampshire => 40720.00,
                        :new_jersey	=> 33487.00,
                        :new_mexico	=> 36421.00,
                        :new_york => 45454.00,
                        :north_carolina	=>33568.00,
                        :north_dakota => 38049.00,
                        :ohio => 34013.00,
                        :oklahoma => 26480.00,
                        :oregon => 31462.00,
                        :pennsylvania	=> 29410.00,
                        :rhode_island	=> 36324.00,
                        :south_carolina	=> 28141.00,
                        :south_dakota	=> 32991.00,
                        :tennessee	=> 26645.00,
                        :texas	=> 29329.00,
                        :utah	=> 29176.00,
                        :vermont	=> 35554.00,
                        :virginia	=> 32545.00,
                        :washington	=> 28160.00,
                        :west_virginia => 28283.00,
                        :wisconsin	=>31468.00,
                        :wyoming	=> 33855.00
    )
    
  end

  def self.down
    
      @rateThreshold = MedicaidAnnualThreshold.find(:first, :conditions => ['start_date > ? AND end_date < ?',  Date.new(2011,01,01), Date.new(2011,12,31)])
      @rateThreshold.delete
  end
end
