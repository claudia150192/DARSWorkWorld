class UpdateWebtipTipTip1619bDisplayRuleAndText < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
    #36 38	190	If your earnings go up enough to make your SSI cash benefit go down to zero, then you should continue to be eligible for Medicaid under a program called "Medicaid While Working--1619b" until you make enough that you don't need Medicaid.  You must tell your SSA Claims Representative that you need Medicaid in order to work, and then tell the agency that administers your Medicaid that you are eligible under 1619b.  See the help topic on 1619b.	Medicaid	1.00	
    #Tip_1619b	IF SsiGet = YES AND VA_CaidGetCoveredGroup = SSI Recipient		no		21.00
    
    @Tip_1619b = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_1619b']) 
    @Tip_1619b.update_attribute(:text, 'If your earnings go up enough to make your SSI cash benefit go down to zero, then you should continue to be eligible for Medicaid under a program called "Medicaid While Working--1619b" until you make enough that you do not need Medicaid.  You must tell your SSA Claims Representative that you need Medicaid in order to work, and then tell the agency that administers your Medicaid that you are eligible under 1619b.  See the help topic on 1619b.') 
   
    #IF SsiGet = YES AND VA_CaidGetCoveredGroup = SSI Recipient
    @Tip_1619b.update_attribute(:display_rules, "
    SsiGet = manager.get_answer_by_question_name('SsiGet')
    VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
    if SsiGet == 'Yes' && VA_CaidGetCoveredGroup == 'SSI Recipient' then 
      true
    else
      false
    end    
    ")

  end

  def self.down
  end
end
