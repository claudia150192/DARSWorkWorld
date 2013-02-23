class UpdateWebtipTipSsdiOwnEarnRecordDisplayRule < ActiveRecord::Migration
  def self.up
    #37	210	If your SSDI eligibility and amount are based on your own past earnings, then any dependents you have may also be eligible for payments.  Do not count their cash benefits as your income unless WW-Web specifically asks you to do so.  You should be aware that if you become ineligible for SSDI, payments to your dependents will stop.	SSDI	2.00	
    #Tip_Ssdi_OwnEarnRecord	IF SsdiGet = YES AND SsdiEarnRec <> Other		Appear		23.00
 
  #If your SSDI eligibility and amount are based on your own past earnings, then any dependents you have may also be eligible for payments.  Do not count their cash benefits as your income unless WW-Web specifically asks you to do so.  You should be aware that if you become ineligible for SSDI, payments to your dependents will stop.
  #If your SSDI eligibility and amount are based on your own past earnings, then any dependents you have may also be eligible for payments.  Do not count their cash benefits as your income unless WW-Web specifically asks you to do so.  You should be aware that if you become ineligible for SSDI, payments to your dependents will stop.  
    @Tip_Ssdi_OwnEarnRecord = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_Ssdi_OwnEarnRecord'])
    
    #IF SsdiGet = YES AND SsdiEarnRec <> Other	
            
    @Tip_Ssdi_OwnEarnRecord.update_attribute(:display_rules, "
    SsdiGet = manager.get_answer_by_question_name('SsdiGet')
    SsdiEarnRec = manager.get_answer_by_question_name('SsdiEarnRec')
    if (SsdiGet == 'Yes' && SsdiEarnRec != 'Other') then
      true
    else
     false
    end
    ") unless @Tip_Ssdi_OwnEarnRecord.blank?
  end

  def self.down
  end
end
