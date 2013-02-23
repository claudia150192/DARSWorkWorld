class Add2011RecordToFederalPovertyLevels2 < ActiveRecord::Migration
    def self.up
      FederalPovertyLevel.create!(:start_date => Date.new(2011,01,01), 
                          :end_date => Date.new(2011,12,31),
                          :family_size_1 => 10890, 
                          :family_size_2 => 14710, 
                          :family_size_3 => 18530, 
                          :family_size_4 => 22350,
                          :family_size_5 => 26170,
                          :family_size_6 => 29990,
                          :family_size_7 => 33810,
                          :family_size_8 => 37630,
                          :family_size_9 => 41450,
                          :family_size_10 => 45270,
                          :family_size_11 => 49090,
                          :family_size_12 => 52910,
                          :family_size_13 => 56730,
                          :family_size_14 => 60550,
                          :family_size_15 => 64370,
                          :additional => 3820.00
      )
  end

    def self.down

      @rateFPL = FederalPovertyLevel.find(:first, :conditions => ['start_date > ? AND end_date < ?',  Date.new(2011,01,01), Date.new(2011,12,31)])
      @rateFPL.delete unless @rateFPL.blank?
    end
  end
 
