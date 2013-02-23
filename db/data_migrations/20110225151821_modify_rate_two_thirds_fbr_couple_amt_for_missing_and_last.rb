class ModifyRateTwoThirdsFbrCoupleAmtForMissingAndLast < ActiveRecord::Migration
  def self.up
    @RateTwoThirdsFbrCoupleAmt = WebCalc.find_by_name('RateTwoThirdsFbrCoupleAmt')
    if @RateTwoThirdsFbrCoupleAmt.blank? then
      @RateTwoThirdsFbrCoupleAmt = WebCalc.new(:name => 'RateTwoThirdsFbrCoupleAmt')
    end

@RateTwoThirdsFbrCoupleAmt.update_attribute(:operation, 
"unless manager.get_answer_by_question_name('SitDate').blank? 
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
  if !(rate.blank?) then
   RateTwoThirdsFbrCoupleAmt = rate.two_thirds_fbr_couple_amount
  else
    RateTwoThirdsFbrCoupleAmt = 674
  end
  return RateTwoThirdsFbrCoupleAmt
 else 
  674
end
")
 end

  def self.down
    @RateTwoThirdsFbrCoupleAmt = WebCalc.find_by_name('RateTwoThirdsFbrCoupleAmt')
    if !(@RateTwoThirdsFbrCoupleAmt.blank?) then
     @RateTwoThirdsFbrCoupleAmt.update_attribute(:operation,
     "unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
        rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
         RateTwoThirdsFbrCoupleAmt= 674
         RateTwoThirdsFbrCoupleAmt = rate.two_thirds_fbr_couple_amount unless @rate.blank?
         return RateTwoThirdsFbrCoupleAmt
        else 
         674
       end
     ")
  end
 end
end