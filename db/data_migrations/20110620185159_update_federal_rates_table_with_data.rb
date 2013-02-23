class UpdateFederalRatesTableWithData < ActiveRecord::Migration
  def self.up
    
     @rate = FederalRate.find(:last, :conditions => ['start_date = ?', '2010-01-01 00:00:00'])
     
      unless @rate.blank?
        @rate.update_attribute(:RateCaidMostGroupsResourceLimit, "2000.00")  
        @rate.update_attribute(:RateCoupleCaidMostGroupsResourceLimit, "3000.00")  
        @rate.update_attribute(:RateQwdiResouceLimit, "4000.00")         
        @rate.update_attribute(:RateCoupleQwdiResouceLimit, "6000.00")  
        @rate.update_attribute(:RateQmbSlmbQiResouceLimit, "6680.00")  
        @rate.update_attribute(:RateCoupleQmbSlmbQiResouceLimit, "10020.00")  
        @rate.update_attribute(:RateLtcCaidSpousalResourceStandard, "21912.00")  
        @rate.update_attribute(:RateLtcCaidSpousalMaxResourceStandard, "109560.00") 
        @rate.update_attribute(:RateInfreqOrIrregUnearnPerQuarterAmt, "60.00") 
        @rate.update_attribute(:RateInfreqOrIrregEarnPerQuarterAmt, "30.00") 
      end
    
    #2011-01-01 05:00:00
    @rate1 = FederalRate.find(:last, :conditions => ['start_date = ?', '2011-01-01 05:00:00'])
      
      unless @rate1.blank?
        @rate1.update_attribute(:RateCaidMostGroupsResourceLimit, "2000.00")  
        @rate1.update_attribute(:RateCoupleCaidMostGroupsResourceLimit, "3000.00")  
        @rate1.update_attribute(:RateQwdiResouceLimit, "4000.00")         
        @rate1.update_attribute(:RateCoupleQwdiResouceLimit, "6000.00")  
        @rate1.update_attribute(:RateQmbSlmbQiResouceLimit, "6680.00")  
        @rate1.update_attribute(:RateCoupleQmbSlmbQiResouceLimit, "10020.00")  
        @rate1.update_attribute(:RateLtcCaidSpousalResourceStandard, "21912.00")  
        @rate1.update_attribute(:RateLtcCaidSpousalMaxResourceStandard, "109560.00") 
        @rate1.update_attribute(:RateInfreqOrIrregUnearnPerQuarterAmt, "60.00") 
        @rate1.update_attribute(:RateInfreqOrIrregEarnPerQuarterAmt, "30.00") 
      end
    
  end

  def self.down
  end
end
