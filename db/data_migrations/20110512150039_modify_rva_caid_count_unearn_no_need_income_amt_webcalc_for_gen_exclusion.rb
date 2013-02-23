class ModifyRvaCaidCountUnearnNoNeedIncomeAmtWebcalcForGenExclusion < ActiveRecord::Migration
  def self.up
      
       @R_VA_CaidCountUnearnNoNeedIncomeAmt = WebCalc.find_by_name('R_VA_CaidCountUnearnNoNeedIncomeAmt ')
        if @R_VA_CaidCountUnearnNoNeedIncomeAmt.blank? then
          @R_VA_CaidCountUnearnNoNeedIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidCountUnearnNoNeedIncomeAmt ')
        end

    @R_VA_CaidCountUnearnNoNeedIncomeAmt.update_attribute(:operation, 
    " UnearnInfrequentAmt = manager.get_answer_by_question_name('UnearnInfrequentAmt')
     R_VA_CaidUnearnAmt = WebCalc.find_by_name('R_VA_CaidUnearnAmt')
     R_VA_CaidUnearnAmt = Float(R_VA_CaidUnearnAmt.calculate manager)
     UnearnIncomeBasedOnNeedAmt = manager.get_answer_by_question_name('UnearnIncomeBasedOnNeedAmt')
     UnearnAssistanceBasedOnNeedAmt = manager.get_answer_by_question_name('UnearnAssistanceBasedOnNeedAmt')
     RateGeneralExclusion = WebCalc.find_by_name('RateGeneralExclusion')
     RateGeneralExclusion = Float(RateGeneralExclusion.calculate manager)
     if UnearnInfrequentAmt.to_f > RateGeneralExclusion then
      [(R_VA_CaidUnearnAmt - UnearnIncomeBasedOnNeedAmt.to_f - UnearnAssistanceBasedOnNeedAmt.to_f - RateGeneralExclusion), 0].max
    else
      [(R_VA_CaidUnearnAmt - UnearnInfrequentAmt.to_f  - UnearnIncomeBasedOnNeedAmt.to_f - UnearnAssistanceBasedOnNeedAmt.to_f - RateGeneralExclusion), 0].max
    end
    ")
  end

  def self.down
  end
end
