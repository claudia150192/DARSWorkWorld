class ModifyRatePmvAmtForLast < ActiveRecord::Migration
  def self.up
    @RatePmvAmt = WebCalc.find_by_name('RatePmvAmt')
    if @RatePmvAmt.blank? then
      @RatePmvAmt = WebCalc.new(:name => 'RatePmvAmt')
    end
    
@RatePmvAmt.update_attribute(:operation, 
"unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
 if !(rate.blank?) then
   RatePmvAmt = rate.pmv_amount
 else
   RatePmvAmt= 244.67
 end
  return RatePmvAmt
 else 
  244.67
end
")
  end

  def self.down
    @RatePmvAmt = WebCalc.find_by_name('RatePmvAmt')
    if !(@RatePmvAmt.blank?) then
     @RatePmvAmt.update_attribute(:operation,
     "unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
      rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
      if !(rate.blank?) then
        RatePmvAmt = rate.pmv_amount
      else
        RatePmvAmt= 244.67
      end
       return RatePmvAmt
      else 
       244.67
     end
     ")
  end
  end
end