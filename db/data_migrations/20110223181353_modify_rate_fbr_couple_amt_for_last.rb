class ModifyRateFbrCoupleAmtForLast < ActiveRecord::Migration
  def self.up
    @RateFbrCoupleAmt = WebCalc.find_by_name('RateFbrCoupleAmt')
    if @RateFbrCoupleAmt.blank? then
      @RateFbrCoupleAmt  = WebCalc.new(:name => 'RateFbrCoupleAmt')
    end
    
@RateFbrCoupleAmt.update_attribute(:operation, 
"unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
  if !(rate.blank?) then
    RateFbrCoupleAmt = rate.fbr_couple_amount
  else
    RateFbrCoupleAmt= 1011
  end
  return RateFbrCoupleAmt
 else 
  1011
end
")
  end

  def self.down
    @RateFbrCoupleAmt = WebCalc.find_by_name('RateFbrCoupleAmt')
    if !(@RateFbrCoupleAmt.blank?) then
     @RateFbrCoupleAmt.update_attribute(:operation,
     "unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
      rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
       if !(rate.blank?) then
         RateFbrCoupleAmt = rate.fbr_couple_amount
       else
         RateFbrCoupleAmt= 1011
       end
       return RateFbrCoupleAmt
      else 
       1011
     end
     ")
  end
 end
end