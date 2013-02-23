class UpdateQuestionCareBPremiumAmtDisplayRule < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'

    @CareBPremiumAmt = Question.find(:first, :conditions => ['name = ?',  'CareBPremiumAmt']) 

   # 31 38	48.4	How much is your Medicare Part B Premium?	CareBPremiumAmt			Zero or Positive Number	Enter positive numbers only.  Do not enter $.	EXPRESSION: RateCareBPremium for SitDate	IF CareBGet = Y	Appear	96.50		49.00
    
    #IF CareBGet = Y  Bob added State and CareAGet 
    @CareBPremiumAmt.update_attribute(:display_rules, "
    State = manager.get_answer_by_question_name('State')
    CareAGet = manager.get_answer_by_question_name('CareAGet')
    CareBGet = manager.get_answer_by_question_name('CareBGet')
    State == 'Virginia' && CareAGet == 'Yes' && CareBGet == 'Yes'") unless @CareBPremiumAmt.blank?
  end

  def self.down
  end
end
