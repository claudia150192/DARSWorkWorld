class CreateExclusionWebratesWebcalc < ActiveRecord::Migration
  def self.up
        require 'wwweb_session_manager'  

      #these are used in many differnet calcs, put it in one place

      @RateGeneralExclusion  = WebCalc.new(:name => 'RateGeneralExclusion')
      @RateGeneralExclusion.operation = "
   unless manager.get_answer_by_question_name('SitDate').blank? 
    SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
    rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
     if !(rate.blank?) then
       GeneralExclusion = rate.gen_exclude_amount
     else
       GeneralExclusion = 20
     end
     return GeneralExclusion
    else 
     20
   end
  "
   @RateGeneralExclusion.save!
   
   
       @RateEarnedIncomeDisregard  = WebCalc.new(:name => 'RateEarnedIncomeDisregard')
       @RateEarnedIncomeDisregard.operation = "
    unless manager.get_answer_by_question_name('SitDate').blank? 
     SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
     rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
      if !(rate.blank?) then
        EarnedIncomeDisregard = rate.earned_inc_disregard_amount
      else
        EarnedIncomeDisregard = 65
      end
      return EarnedIncomeDisregard
     else 
      65
    end
   "
    @RateEarnedIncomeDisregard.save!
  end

  def self.down
  end
end
