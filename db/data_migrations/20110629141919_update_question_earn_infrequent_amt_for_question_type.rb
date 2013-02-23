class UpdateQuestionEarnInfrequentAmtForQuestionType < ActiveRecord::Migration
  def self.up
       
    require 'wwweb_session_manager'  
       #46	103.5	How much of the ~$SsiOrCaidEarnAmt~ you Receive is infrequent or irregular?	EarnInfrequentAmt			Zero or Positive Number 	Enter positive numbers only.  Do not enter $.	0	If SsiOrCaidEarnAmt > 0	Appear	5.00	TIP NEEDED:  FOR VA MEDICAID PURPOSES, IF USER + SPOUSE'S INFREQ OR IRREG EARNED INCOME > $10, IT CANNOT BE EXCLUDED.   (See M0810.410)	108.50
  
      #EarnInfrequentAmt question edit to add insert marker
      @EarnInfrequentAmt = Question.find(:first, :conditions => ['name = ?',  'EarnInfrequentAmt']) 
      @EarnInfrequentAmt.update_attribute(:question_type, "text_field") unless @EarnInfrequentAmt.blank?
      @EarnInfrequentAmt.update_attribute(:default_answer, "0.00") unless @EarnInfrequentAmt.blank?
      @EarnInfrequentAmt.update_attribute(:validation_message, "You can not enter an amount higher than your monthly gross wages, salary or self-employment earnings. Enter positive numbers only.  Do not enter $.") unless @EarnInfrequentAmt.blank?
      
      @EarnInfrequentAmt.update_attribute(:validation_rules, "answer = manager.get_answer_by_question_name(self.name)
         SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
         if answer != nil then
           DoWeFloat = (true if (Float(answer) >= 0) rescue false)
           if DoWeFloat then 
             Float(answer) <= SsiOrCaidEarnAmt.to_f 
           else
             false
           end  
         else 
           true
         end
      ") unless @EarnInfrequentAmt.blank?
  end

  def self.down
  end
end
