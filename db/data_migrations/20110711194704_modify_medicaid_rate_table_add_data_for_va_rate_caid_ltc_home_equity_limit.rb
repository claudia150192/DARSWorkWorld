class ModifyMedicaidRateTableAddDataForVaRateCaidLtcHomeEquityLimit < ActiveRecord::Migration
  def self.up
     
      @rate_record = VaMedicaidRate.find(:first, :conditions => ['start_date = ?', '2010-01-01 00:00:00'])
    
       unless @rate_record.blank?
         @rate_record.update_attribute(:va_rate_caid_ltc_home_equity_limit, "506000.00")  
       end
  end

  def self.down
  end
end
