class ModifyRateTwoThirdsFbrAmtForMissingAndLast < ActiveRecord::Migration
  def self.up
    @RateTwoThirdsFbrAmt = WebCalc.find_by_name('RateTwoThirdsFbrAmt')
    if @RateTwoThirdsFbrAmt.blank? then
      @RateTwoThirdsFbrAmt = WebCalc.new(:name => 'RateTwoThirdsFbrAmt')
    end

@RateTwoThirdsFbrAmt.update_attribute(:operation, 
"unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
 if !(rate.blank?) then
   RateTwoThirdsFbrAmt = rate.two_thirds_fbr_amount
  else
    RateTwoThirdsFbrAmt = 450
  end
  return RateTwoThirdsFbrAmt
 else 
  450
end
")
  end

  def self.down
    @RatePmvCoupleAmt = WebCalc.find_by_name('RatePmvCoupleAmt')
    if !(@RatePmvCoupleAmt.blank?) then
     @RatePmvCoupleAmt.update_attribute(:operation,
     "  unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
        rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
         RateTwoThirdsFbrAmt= 0
         RateTwoThirdsFbrAmt = rate.two_thirds_fbr_amount unless @rate.blank?
         return RateTwoThirdsFbrAmt
        else 
         450
       end
     ")
  end
 end
end
