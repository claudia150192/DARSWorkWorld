class ModifyInKindPmvAmtDefaultAndValidationForMissingAndLast < ActiveRecord::Migration
  def self.up
    @question = Question.find_by_name('InKindPMVAmt')
    @question.update_attribute(:validation_rules,
  "answer = manager.get_answer_by_question_name(self.name)
   SsiGet = manager.get_answer_by_question_name('SsiGet')
   LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
   SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
   RatePmvCoupleAmt = WebCalc.find_by_name('RatePmvCoupleAmt')
   RatePmvCoupleAmt = Float(RatePmvCoupleAmt.calculate manager)
   RatePmvAmt = WebCalc.find_by_name('RatePmvAmt')
   RatePmvAmt = Float(RatePmvAmt.calculate manager)
   if SsiGet == 'Yes' && SpouseSsiGet == 'Yes' && LiveWithSpouse == 'Yes' then
     RateToUse = RatePmvCoupleAmt
   else
     RateToUse = RatePmvAmt 
   end

   if answer != nil then
     DoWeFloat = (true if (Float(answer) >= 0) rescue false)
     if DoWeFloat then 
       Float(answer) <= RateToUse 
     else
       false
     end  
   else 
     true
   end
  ") unless @question.blank?
    
  @question.update_attribute(:default_answer,
 "expression= 
  SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
  LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
  RatePmvCoupleAmt = WebCalc.find_by_name('RatePmvCoupleAmt') 
  RatePmvCoupleAmt = Float(RatePmvCoupleAmt.calculate manager)  
  RatePmvAmt  = WebCalc.find_by_name('RatePmvAmt') 
  RatePmvAmt = Float(RatePmvAmt.calculate manager)
  if SpouseSsiGet == 'Yes' && LiveWithSpouse == 'Yes' then
   answer = RatePmvCoupleAmt
  else
   answer = RatePmvAmt
  end
") unless @question.blank?

end

  def self.down
      
    @question = Question.find_by_name('InKindPMVAmt')
    @question.update_attribute(:default_answer,
   "expression= 
    SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
    RatePmvCoupleAmt= 357
    RatePmvAmt= 244.67
    RatePmvCoupleAmt = WebCalc.find_by_name('RatePmvCoupleAmt') unless WebCalc.find_by_name('RatePmvCoupleAmt').blank?
    RatePmvCoupleAmt = Float(RatePmvCoupleAmt.calculate manager)  
    RatePmvAmt = WebCalc.find_by_name('RatePmvAmt') unless WebCalc.find_by_name('RatePmvAmt').blank? 
    RatePmvAmt = Float(RatePmvAmt.calculate manager)
    if SpouseSsiGet == 'Yes' then
     answer = RatePmvCoupleAmt
    else
     answer = RatePmvAmt
    end
  ") unless @question.blank?
      
    @question = Question.find_by_name('InKindPMVAmt')
    @question.update_attribute(:validation_rules,
  "true
  ") unless @question.blank?

  end
end