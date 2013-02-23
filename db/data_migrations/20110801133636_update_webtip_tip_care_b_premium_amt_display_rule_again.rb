class UpdateWebtipTipCareBPremiumAmtDisplayRuleAgain < ActiveRecord::Migration
  def self.up
    
    @Tip_CareBPremiumAmt = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_CareBPremiumAmt'])
    
    #IF CareBDeduct = NO AND CareBPaySelf = NO AND CaidGet = YES
    
    @Tip_CareBPremiumAmt.update_attribute(:display_rules, "
    CaidGet = manager.get_answer_by_question_name('CaidGet')
    CareBDeduct = manager.get_answer_by_question_name('CareBDeduct')
    CareBPaySelf = manager.get_answer_by_question_name('CareBPaySelf')
    CareBDeduct == 'No' && CareBPaySelf == 'No' && CaidGet == 'Yes'") unless @Tip_CareBPremiumAmt.blank?
    
  end

  def self.down
  end
end
