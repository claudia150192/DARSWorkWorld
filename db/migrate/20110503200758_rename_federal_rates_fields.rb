class RenameFederalRatesFields < ActiveRecord::Migration
  def self.up
    
     rename_column :federal_rates, :care_b_premium, :RateCareBPremium
     rename_column :federal_rates, :ssi_resource_limit, :RateSsiResourceLimit
     rename_column :federal_rates, :ssi_resource_limit_married, :RateCoupleSsiResourceLimit
     
  end

  def self.down
   
    rename_column :federal_rates, :RateCareBPremium, :care_b_premium
    rename_column :federal_rates, :RateSsiResourceLimit, :ssi_resource_limit
    rename_column :federal_rates, :RateCoupleSsiResourceLimit, :ssi_resource_limit_married
    
  end
end
