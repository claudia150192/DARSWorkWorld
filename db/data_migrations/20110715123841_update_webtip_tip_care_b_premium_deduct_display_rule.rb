class UpdateWebtipTipCareBPremiumDeductDisplayRule < ActiveRecord::Migration
  def self.up
    
    #37	240	Your Medicare Part B premium is not deducted from your SSDI cash payment if you have some form of Medicaid that pays the premium.  It is also not deducted if your SSDI cash payment is zero because you earn over the SGA amount.  In that case you must pay the premium out-of-pocket.	Medicare	1.00	
    #Tip_CareBPremiumDeduct	IF CareBGet = YES AND CareBDeduct <> YES AND CareBPaySelf <> YES		Appear		26.00
    
    #Your Medicare Part B premium is not deducted from your SSDI cash payment if you have some form of Medicaid that pays the premium.  It is also not deducted if your SSDI cash payment is zero because you earn over the SGA amount.  In that case you must pay the premium out-of-pocket.
    #Your Medicare Part B premium is not deducted from your SSDI cash payment if you have some form of Medicaid that pays the premium.  It is also not deducted if your SSDI cash payment is zero because you earn over the SGA amount.  In that case you must pay the premium out-of-pocket.
        
    @Tip_CareBPremiumDeduct = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_CareBPremiumDeduct'])
    
    #IIF CareBGet = YES AND CareBDeduct <> YES AND CareBPaySelf <> YES
    @Tip_CareBPremiumDeduct.update_attribute(:display_rules, "
    CareBGet = manager.get_answer_by_question_name('CareBGet')
    CareBDeduct = manager.get_answer_by_question_name('CareBDeduct')
    CareBPaySelf = manager.get_answer_by_question_name('CareBPaySelf')
    if (CareBGet == 'Yes' && CareBDeduct != 'Yes' && CareBPaySelf != 'Yes') then
      true
    else
     false
    end
    ") unless @Tip_CareBPremiumDeduct.blank?
  end

  def self.down
  end
end
