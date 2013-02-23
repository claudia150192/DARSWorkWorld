class UpdateQuestionsDisplayRuleForSsiCoupleResourceLimitExceed < ActiveRecord::Migration
  def self.up
    
    #27 40	80	Do you and your spouse have countable resources that exceed the <RateCoupleSsiResourceLimit> SSI resource limit? (Do not count resources included in a PASS)	
    #SsiCoupleResourceLimitExceed			YES:NO		NO	If SsiGet = Y AND LiveWithSpouse = Y AND (SpouseSsiGet = Y OR SsiSpouseDeem = Y)	no			85.00
    
      @SsiCoupleResourceLimitExceed = Question.find(:first, :conditions => ['name = ?',  'SsiCoupleResourceLimitExceed']) 
      
      #Bah this is a bug.  If a question is not asked the system remembers the last saved answer.  So since LiveWithSpouse is not asked it remembers the last saved case
      #so for now i'm adding Married == yes since this is the intent


       #If SsiGet = Y AND LiveWithSpouse = Y AND (SpouseSsiGet = Y OR SsiSpouseDeem = Y)
      @SsiCoupleResourceLimitExceed.update_attribute(:display_rules, "
      SsiGet = manager.get_answer_by_question_name('SsiGet')
      LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
      SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
      Married = manager.get_answer_by_question_name('Married')
      SsiSpouseDeem = manager.get_answer_by_question_name('SsiSpouseDeem')
      (SsiGet == 'Yes' && Married == 'Yes' && LiveWithSpouse == 'Yes' && (SpouseSsiGet == 'Yes' || SsiSpouseDeem == 'Yes'))") unless @SsiCoupleResourceLimitExceed.blank?
  end

  def self.down
  end
end
