class CreateRvaCaidSpouseCountUnearnNoNeedIncomeAmtWebcalc < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  
     
      @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt ')
         if @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt.blank? then
           @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt ')
         end
     
     
    #  1550	Spouse's Countable Unearned Income (Can't be < 0)	R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt
    #=IF(E155>20; MAX(0; E153-E157-E159-E161);MAX(0;E153-E155-E157-E159-E161))
    #e155 SpouseUnearnInfrequentAmt
    #e153 R_VA_CaidSpouseUnearnAmt
    #E157 SpouseUnearnIncomeBasedOnNeedAmt
    #e159 SpouseUnearnAssistanceBasedOnNeedAmt
    #e161 R_VA_CaidSpouseExcessUserGenExclude
    
     @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt.operation = "
     SpouseUnearnInfrequentAmt = manager.get_answer_by_question_name('SpouseUnearnInfrequentAmt')
     SpouseUnearnIncomeBasedOnNeedAmt = manager.get_answer_by_question_name('SpouseUnearnIncomeBasedOnNeedAmt')
     SpouseUnearnAssistanceBasedOnNeedAmt = manager.get_answer_by_question_name('SpouseUnearnAssistanceBasedOnNeedAmt')
     R_VA_CaidSpouseUnearnAmt = WebCalc.find_by_name('R_VA_CaidSpouseUnearnAmt')
     R_VA_CaidSpouseUnearnAmt = Float(R_VA_CaidSpouseUnearnAmt.calculate manager)
     R_VA_CaidSpouseExcessUserGenExclude = WebCalc.find_by_name('R_VA_CaidSpouseExcessUserGenExclude')
     R_VA_CaidSpouseExcessUserGenExclude = Float(R_VA_CaidSpouseExcessUserGenExclude.calculate manager)
     RateGeneralExclusion = WebCalc.find_by_name('RateGeneralExclusion')
     RateGeneralExclusion = Float(RateGeneralExclusion.calculate manager)
     if SpouseUnearnInfrequentAmt.to_f > RateGeneralExclusion then
       [(R_VA_CaidSpouseUnearnAmt - SpouseUnearnIncomeBasedOnNeedAmt.to_f - SpouseUnearnAssistanceBasedOnNeedAmt.to_f - R_VA_CaidSpouseExcessUserGenExclude), 0].max
     else
       [(R_VA_CaidSpouseUnearnAmt - SpouseUnearnInfrequentAmt.to_f  - SpouseUnearnIncomeBasedOnNeedAmt.to_f - SpouseUnearnAssistanceBasedOnNeedAmt.to_f - R_VA_CaidSpouseExcessUserGenExclude), 0].max
     end
     "
     @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt.save!    
  end

  def self.down
  end
end