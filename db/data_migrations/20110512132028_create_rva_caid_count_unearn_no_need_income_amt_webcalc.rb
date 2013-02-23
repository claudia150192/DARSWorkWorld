class CreateRvaCaidCountUnearnNoNeedIncomeAmtWebcalc < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

       #1050	Individual's Countable Unearned Income before adding back any Income Based on Need (Can't be < 0)	R_VA_CaidCountUnearnNoNeedIncomeAmt
       #=IF(E103>20; MAX(0; E101-E105-E107-E109);MAX(0;E101-E103-E105-E107-E109))
       #E103  UnearnInfrequentAmt
       # E101 R_VA_CaidUnearnAmt
       # E105 UnearnIncomeBasedOnNeedAmt
       #e107  UnearnAssistanceBasedOnNeedAmt
       #e109 RateGenExcludeAmt
       #note this needs to be edited to add the  RateGenExcludeAmt as a calc and not a hardwaire
           
    @R_VA_CaidCountUnearnNoNeedIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidCountUnearnNoNeedIncomeAmt')
    @R_VA_CaidCountUnearnNoNeedIncomeAmt.operation = "
   UnearnInfrequentAmt = manager.get_answer_by_question_name('UnearnInfrequentAmt')
   R_VA_CaidUnearnAmt = WebCalc.find_by_name('R_VA_CaidUnearnAmt')
   R_VA_CaidUnearnAmt = Float(R_VA_CaidUnearnAmt.calculate manager)
   UnearnIncomeBasedOnNeedAmt = manager.get_answer_by_question_name('UnearnIncomeBasedOnNeedAmt')
   UnearnAssistanceBasedOnNeedAmt = manager.get_answer_by_question_name('UnearnAssistanceBasedOnNeedAmt')
   RateGeneralExclusion = 20.00
  if UnearnInfrequentAmt.to_f > RateGeneralExclusion then
    [(R_VA_CaidUnearnAmt - UnearnIncomeBasedOnNeedAmt.to_f - UnearnAssistanceBasedOnNeedAmt.to_f - RateGeneralExclusion), 0].max
  else
    [(R_VA_CaidUnearnAmt - UnearnInfrequentAmt.to_f  - UnearnIncomeBasedOnNeedAmt.to_f - UnearnAssistanceBasedOnNeedAmt.to_f - RateGeneralExclusion), 0].max
  end
  "
       @R_VA_CaidCountUnearnNoNeedIncomeAmt.save!
  end

  def self.down
  end
end
