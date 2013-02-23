class UpdateFederalRatesTableRenameAndLtc < ActiveRecord::Migration
  def self.up
     rename_column :federal_rates, :RateSsiCaidMostGroupsResourceLimit, :RateCaidMostGroupsResourceLimit 
     rename_column :federal_rates, :RateCoupleSsiCaidMostGroupsResourceLimit, :RateCoupleCaidMostGroupsResourceLimit 
     add_column :federal_rates, :RateLtcCaidSpousalResourceStandard, :float
     add_column :federal_rates, :RateLtcCaidSpousalMaxResourceStandard, :float
     add_column :federal_rates, :RateInfreqOrIrregUnearnPerQuarterAmt, :float
     add_column :federal_rates, :RateInfreqOrIrregEarnPerQuarterAmt, :float
   
  end

  def self.down
     rename_column :federal_rates, :RateCoupleCaidMostGroupsResourceLimit, :RateCoupleSsiCaidMostGroupsResourceLimit 
    rename_column :federal_rates, :RateCaidMostGroupsResourceLimit, :RateSsiCaidMostGroupsResourceLimit 
  end
end
