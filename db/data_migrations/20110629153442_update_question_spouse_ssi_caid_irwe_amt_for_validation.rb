class UpdateQuestionSpouseSsiCaidIrweAmtForValidation < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
       #25	148	How much of your spouse's $SpouseDisWorkExpAmt of disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?	
       #SpouseSsiCaidIrweAmt			Zero or Positive Number  =< SpouseDisWorkExpAmt	You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses (SpouseDisWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: SpouseDisWorkExpAmt	If SpouseSsiGet = Y AND SpouseDisWorkExpAmt > 0 AND (SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0 AND SpouseBlind = NO	Appear	400.00		154.00

      #SpouseSsiCaidIrweAmt question edit to add insert marker
      @SpouseSsiCaidIrweAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSsiCaidIrweAmt']) 
     
     
      @SpouseSsiCaidIrweAmt.update_attribute(:validation_message, "You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses.  Do not enter $.") unless @SpouseSsiCaidIrweAmt.blank?
      
      @SpouseSsiCaidIrweAmt.update_attribute(:validation_rules, "answer = manager.get_answer_by_question_name(self.name)
      SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
      if SpouseDisWorkExpAmt != nil then
       SpouseDisWorkExpAmt = Float(SpouseDisWorkExpAmt)
      else
        SpouseDisWorkExpAmt = 0
      end

      if answer != nil then
          true if ((Float(answer) >= 0) && Float(answer) <= SpouseDisWorkExpAmt) rescue false
        else 
          true
      end
   ") unless @SpouseSsiCaidIrweAmt.blank?
   
  end

  def self.down
  end
end
