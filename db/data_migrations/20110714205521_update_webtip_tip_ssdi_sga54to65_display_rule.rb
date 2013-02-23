class UpdateWebtipTipSsdiSga54to65DisplayRule < ActiveRecord::Migration
  def self.up
    
    #37	230	If you are blind, between the ages of 54 and 65, and earning more than SGA, you will not lose eligibility for SSDI as long as your skills and abilities are different from what they were before age 55 or before the onset of blindness, whichever is later.  During your Extended Period of Eligibility (EPE) your SSDI cash payment will stop in SGA months, but your EPE will not cease.  	SSDI	4.00	
    #Tip_Ssdi_Sga54to65	IF BlindSkillsBefore55 = YES OR BlindSkillsBeforeOnset = YES		no		25.00
   
   #If you are blind, between the ages of 54 and 65, and earning more than SGA, you will not lose eligibility for SSDI as long as your skills and abilities are different from what they were before age 55 or before the onset of blindness, whichever is later.  During your Extended Period of Eligibility (EPE) your SSDI cash payment will stop in SGA months, but your EPE will not cease.
   #If you are blind, between the ages of 54 and 65, and earning more than SGA, you will not lose eligibility for SSDI as long as your skills and abilities are different from what they were before age 55 or before the onset of blindness, whichever is later.  During your Extended Period of Eligibility (EPE) your SSDI cash payment will stop in SGA months, but your EPE will not cease.
    
    @Tip_Ssdi_Sga54to65 = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_Ssdi_Sga54to65'])
    
    #IF BlindSkillsBefore55 = YES OR BlindSkillsBeforeOnset = YES
    @Tip_Ssdi_Sga54to65.update_attribute(:display_rules, "
    BlindSkillsBefore55 = manager.get_answer_by_question_name('BlindSkillsBefore55')
    BlindSkillsBeforeOnset = manager.get_answer_by_question_name('BlindSkillsBeforeOnset')
    if (BlindSkillsBefore55 == 'Yes' || BlindSkillsBeforeOnset == 'Yes') then
      true
    else
     false
    end
    ") unless @Tip_Ssdi_Sga54to65.blank?
  end

  def self.down
  end
end
