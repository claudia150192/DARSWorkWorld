class ModifyGeneralExclusionAndEarnedIncomeDisregardForMissingRateAndSql < ActiveRecord::Migration
  def self.up
    @RateGenExcludeAmt = WebCalc.find_by_name('RateGenExcludeAmt ')
    if @RateGenExcludeAmt.blank? then
      @RateGenExcludeAmt  = WebCalc.new(:name => 'RateGenExcludeAmt ')
    end
    
@RateGenExcludeAmt.update_attribute(:operation, 
"unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
 if !(rate.blank?) then
   RateGenExcludeAmt = rate.gen_exclude_amount
 else
   RateGenExcludeAmt = 20
 end
 
  return RateGenExcludeAmt
 else 
  20
end
")

    @RateEarnedIncDisregardAmt = WebCalc.find_by_name('RateEarnedIncDisregardAmt ')
    if @RateEarnedIncDisregardAmt.blank? then
      @RateEarnedIncDisregardAmt  = WebCalc.new(:name => 'RateEarnedIncDisregardAmt ')
    end
    
@RateEarnedIncDisregardAmt.update_attribute(:operation, 
"unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
  if !(rate.blank?) then
    RateEarnedIncDisregardAmt = rate.earned_inc_disregard_amount
  else
    RateEarnedIncDisregardAmt= 65
  end
  return RateEarnedIncDisregardAmt
 else 
  65
end
")


  end

  def self.down
    @RateEarnedIncDisregardAmt = WebCalc.find_by_name('RateEarnedIncDisregardAmt')
    if !(@RateEarnedIncDisregardAmt.blank?) then
     @RateEarnedIncDisregardAmt.update_attribute(:operation,
     "unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
      rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
       if !(rate.blank?) then
         RateEarnedIncDisregardAmt = rate.earned_inc_disregard_amount
       else
         RateEarnedIncDisregardAmt= 65
       end
       return RateEarnedIncDisregardAmt
      else 
       65
     end
     ")
    end


    @RateGenExcludeAmt = WebCalc.find_by_name('RateGenExcludeAmt')
    if !(@RateGenExcludeAmt.blank?) then
     @RateGenExcludeAmt.update_attribute(:operation,
     "unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
      rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
      if !(rate.blank?) then
        RateGenExcludeAmt = rate.gen_exclude_amount
      else
        RateGenExcludeAmt = 20
      end

       return RateGenExcludeAmt
      else 
       20
     end
     ")
    end
  end
end
