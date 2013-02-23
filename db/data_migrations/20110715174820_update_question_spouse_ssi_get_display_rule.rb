class UpdateQuestionSpouseSsiGetDisplayRule < ActiveRecord::Migration
  def self.up
    #25 45	51	Spouse SSI: Does your spouse receive SSI?	SpouseSsiGet			YES:NO		NO	If Married = Y AND (SpouseBlind = Y OR SpouseDisability = Y	Appear	YES	If user does not get SSI and spouse does, then we ask this question only to give the spouse a Tip and TR saying that spouse must enter data as user in order to determine SSI eligibility and payment amount.	52.00
    
       @SpouseSsiGet = Question.find(:first, :conditions => ['name = ?',  'SpouseSsiGet']) 
      
      #If Married = Y AND (SpouseBlind = Y OR SpouseDisability = Y
      @SpouseSsiGet.update_attribute(:display_rules, "
      Married = manager.get_answer_by_question_name('Married')
      SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
      SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
      Married ==  'Yes' && (SpouseBlind ==  'Yes' || SpouseDisability ==  'Yes')
      ")  unless @SpouseSsiGet.blank?
  end

  def self.down
  end
end
