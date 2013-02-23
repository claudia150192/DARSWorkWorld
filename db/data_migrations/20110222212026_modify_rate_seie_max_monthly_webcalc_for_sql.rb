class ModifyRateSeieMaxMonthlyWebcalcForSql < ActiveRecord::Migration
  def self.up
    @RateSEIEMaxMonthly = WebCalc.find_by_name('RateSEIEMaxMonthly ')
    if @RateSEIEMaxMonthly.blank? then
      @RateSEIEMaxMonthly  = WebCalc.new(:name => 'RateSEIEMaxMonthly ')
    end
    
@RateSEIEMaxMonthly.update_attribute(:operation, 
"unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
  if !(rate.blank?) then
      RateSEIEMonthly = rate.seie_max_monthly
  else
      RateSEIEMonthly = 1640
  end
  
  return RateSEIEMonthly

else 
  return 1640
end
")
  end

  def self.down
    @RateSEIEMaxMonthly = WebCalc.find_by_name('RateSEIEMaxMonthly')
    if !(@RateSEIEMaxMonthly.blank?) then
     @RateSEIEMaxMonthly.update_attribute(:operation,
     "unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
      rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
       if !(rate.blank?) then
           RateSEIEMonthly = rate.seie_max_monthly
       else
           RateSEIEMonthly = 1640
       end
       return RateSEIEMonthly

     else 
       return '1639.99'
     end
     ")
    end
  end
end
