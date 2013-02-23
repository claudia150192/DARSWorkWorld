class FixInKindPmvAmtValidationRule2 < ActiveRecord::Migration

    def self.up

    @question = Question.find_by_name('InKindPMVAmt')
    @question.update_attribute(:validation_rules,
  "answer = manager.get_answer_by_question_name(self.name)
   SsiGet = manager.get_answer_by_question_name('SsiGet')
   SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
   RatePmvCoupleAmt  = WebCalc.find_by_name('RatePmvCoupleAmt')
   RatePmvCoupleAmt = Float(RatePmvCoupleAmt.calculate manager)
   RatePmvAmt  = WebCalc.find_by_name('RatePmvAmt')
   RatePmvAmt = Float(RatePmvAmt.calculate manager)
   if SsiGet == 'Yes' && SpouseSsiGet == 'Yes' then
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

  end

   def self.down

    @question = Question.find_by_name('InKindPMVAmt')
    @question.update_attribute(:validation_rules,
  "answer = manager.get_answer_by_question_name(self.name)
   SsiGet = manager.get_answer_by_question_name('SsiGet')
   SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
   unless manager.get_answer_by_question_name('SitDate').blank? 
     SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
     rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
     pmv_couple_amount = rate.pmv_couple_amount
     pmv_amount = rate.pmv_amount
     if SsiGet == 'Yes' && SpouseSsiGet == 'Yes' then
       RateToUse = pmv_couple_amount
     else
       RateToUse = pmv_amount 
     end
   else 
     RateToUse= 245
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

   end

  end