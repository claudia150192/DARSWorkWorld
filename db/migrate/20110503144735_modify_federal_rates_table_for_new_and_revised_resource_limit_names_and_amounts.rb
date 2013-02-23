class ModifyFederalRatesTableForNewAndRevisedResourceLimitNamesAndAmounts < ActiveRecord::Migration
  def self.up
    #note decided to use another migration to add amounts
 #   RateSsiCaidMostGroupsResourceLimit
 #   RateCoupleSsiCaidMostGroupsResourceLimit
 #   RateQwdiResouceLimit
 #   RateCoupleQwdiResouceLimit
 #   RateQmbSlmbQiResouceLimit
 #   RateCoupleQmbSlmbQiResouceLimit
 
 #this is bad carma, i gained a learning experience, a typo in a later part of migration, since deleted caused part of this migration to fail even tough these columns were added
 #so i could not rerun the migration without getting "already exists" errors.  The begin and end blocks allow all to process both here and later when pushed to heroku
    begin
       add_column :federal_rates, :RateSsiCaidMostGroupsResourceLimit, :float 
     rescue
       
    end   
     
     begin  
       add_column :federal_rates, :RateCoupleSsiCaidMostGroupsResourceLimit, :float
       add_column :federal_rates, :RateQwdiResouceLimit, :float
       add_column :federal_rates, :RateCoupleQwdiResouceLimit, :float
       add_column :federal_rates, :RateQmbSlmbQiResouceLimit, :float
       add_column :federal_rates, :RateCoupleQmbSlmbQiResouceLimit, :float   
     rescue
       
    end 
     
  end

  def self.down
    #remove_column :question_groups, :next_group_id
    remove_column :federal_rates, :RateSsiCaidMostGroupsResourceLimit
    remove_column :federal_rates, :RateCoupleSsiCaidMostGroupsResourceLimit
    remove_column :federal_rates, :RateQwdiResouceLimit
    remove_column :federal_rates, :RateCoupleQwdiResouceLimit
    remove_column :federal_rates, :RateQmbSlmbQiResouceLimit
    remove_column :federal_rates, :RateCoupleQmbSlmbQiResouceLimit
  end
end
