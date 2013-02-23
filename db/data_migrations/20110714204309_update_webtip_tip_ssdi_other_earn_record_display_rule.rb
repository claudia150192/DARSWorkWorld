class UpdateWebtipTipSsdiOtherEarnRecordDisplayRule < ActiveRecord::Migration
  def self.up
   
   # 37	220	If your SSDI eligibility and amount are based on someone else's past earnings, then any dependents you have will probably not be eligible for payments.  SSA probably calls you a Disabled Adult Child (DAC), which means that one or both of your parents are disabled or deceased.  If your disabled parent loses SSDI eligibility, then you also may lose your DAC eligibility.  	SSDI	3.00	
   #Tip_Ssdi_OtherEarnRecord	IF SsdiGet = YES AND SsdiEarnRec <> Self		no		24.00
   
   
   #If your SSDI eligibility and amount are based on someone else's past earnings, then any dependents you have will probably not be eligible for payments.  SSA probably calls you a Disabled Adult Child (DAC), which means that one or both of your parents are disabled or deceased.  If your disabled parent loses SSDI eligibility, then you also may lose your DAC eligibility.
   #If your SSDI eligibility and amount are based on someone else's past earnings, then any dependents you have will probably not be eligible for payments.  SSA probably calls you a Disabled Adult Child (DAC), which means that one or both of your parents are disabled or deceased.  If your disabled parent loses SSDI eligibility, then you also may lose your DAC eligibility.
    @Tip_Ssdi_OtherEarnRecord = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_Ssdi_OtherEarnRecord'])
    
    #IF SsdiGet = YES AND SsdiEarnRec <> Self
                
    @Tip_Ssdi_OtherEarnRecord.update_attribute(:display_rules, "
    SsdiGet = manager.get_answer_by_question_name('SsdiGet')
    SsdiEarnRec = manager.get_answer_by_question_name('SsdiEarnRec')
    if (SsdiGet == 'Yes' && SsdiEarnRec != 'Self') then
      true
    else
     false
    end
    ") unless @Tip_Ssdi_OtherEarnRecord.blank?
  end

  def self.down
  end
end
