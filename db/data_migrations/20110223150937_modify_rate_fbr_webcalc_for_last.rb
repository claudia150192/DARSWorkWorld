class ModifyRateFbrWebcalcForLast < ActiveRecord::Migration
  def self.up
    @RateFbrAmt = WebCalc.find_by_name('RateFbrAmt')
    if @RateFbrAmt.blank? then
      @RateFbrAmt  = WebCalc.new(:name => 'RateFbrAmt')
    end
    
@RateFbrAmt.update_attribute(:operation, 
"unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
  if !(rate.blank?) then
    RateFbrAmt = rate.fbr_amount
  else
    RateFbrAmt = 674
  end
  return RateFbrAmt
 else 
  674
end
")
  end

  def self.down
    @RateFbrAmt = WebCalc.find_by_name('RateFbrAmt')
    if !(@RateFbrAmt.blank?) then
     @RateFbrAmt.update_attribute(:operation,
     "unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
      rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
       if !(rate.blank?) then
         RateFbrAmt = rate.fbr_amount
       else
         RateFbrAmt = 674
       end
       return RateFbrAmt
      else 
       674
     end
     ")
    end
  end
end