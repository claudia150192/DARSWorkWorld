class ModifyWebtipsForWorkbook36 < ActiveRecord::Migration
  def self.up             
  require 'wwweb_session_manager'
  
   @web_tip_webTipCSI1a = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipCSI1a'])
   @web_tip_webTipCSI1a.delete unless @web_tip_webTipCSI1a.blank? 
   
  @web_tip_webTipCSI1b = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipCSI1b'])
  @web_tip_webTipCSI1b.delete unless @web_tip_webTipCSI1b.blank?

  @web_tip_webTipBlindTest = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipBlindTest'])
  @web_tip_webTipBlindTest.delete unless @web_tip_webTipBlindTest.blank?
  
  @web_tip_webTipNotBlindTest = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipNotBlindTest'])
  @web_tip_webTipNotBlindTest.delete unless @web_tip_webTipNotBlindTest.blank?

  @web_tip_CSABirthDate2 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSABirthDate2'])
  @web_tip_CSABirthDate2.delete unless @web_tip_CSABirthDate2.blank?

  @web_tip_CSABirthDate3 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSABirthDate3'])
  @web_tip_CSABirthDate3.delete unless @web_tip_CSABirthDate3.blank?

  @web_tip_CSASitDate1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSASitDate1'])    
  @web_tip_CSASitDate1.delete unless @web_tip_CSASitDate1.blank?

  @web_tip_CSAState1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSAState1'])
  @web_tip_CSAState1.delete unless @web_tip_CSAState1.blank?

  @web_tip_CSADisability1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSADisability1'])
  @web_tip_CSADisability1.delete unless @web_tip_CSADisability1.blank?

#This is a hack since i don't know how to get the external key
   
 @UserInformation = '63855'
 @HouseholdInfo = '63856'
 @SSI = '63858'
 @Medicaid = '63859'
 @SSDI = '63860'
 @Medicare = '63861'
 
#This is what i wanted to do but after a couple days of struggling i gave up.  ON 4/21/2011 YC came through with a solution so i added this back in for when we send to heroku
   @Tip_SwitchToGroup_CS           =WebTip.create!(:identifier => 'Tip_SwitchToGroup_CS',           :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '1.00',     :workbook_order => '1', :web_numerical_result_id => '',      :text=> 'You must first answer questions about your current situation.  WW-Web is showing you questions one at a time.  You must accept each answer before the next question will appear.  If you would rather see all of the questions in each section at once, select the "Switch to group mode" link above the questions and User Information title.') 
   @Tip_SwitchTo1atTime_CS         =WebTip.create!(:identifier => 'Tip_SwitchTo1atTime_CS',         :display_rules => 'false',        :group_id => @UserInformation,      :group_order => '2.00',     :workbook_order => '2', :web_numerical_result_id => '',      :text=> 'You must first answer questions about your current situation.  WW-Web is showing you questions in group mode.  You can select (click on or tab into) the answers to any of the questions on this page if you want to change them from the default answers.  If you would rather see each question one at a time, select the "Switch to One-at-a-time mode" link above the questions and User Information title.')
   @Tip_Birthdate_CS               =WebTip.create!(:identifier => 'Tip_Birthdate_CS',               :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '3.00',     :workbook_order => '3', :web_numerical_result_id => '',      :text=> 'Enter your birthdate either by typing MM/DD/YEAR or my clicking on the calendar icon.  Then you can accept your answer by clicking on the Accept button or by hitting the <Tab> key and then <Enter>.')
   @Tip_SaveBirthdate_CS           =WebTip.create!(:identifier => 'Tip_SaveBirthdate_CS',           :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '4.00',     :workbook_order => '4', :web_numerical_result_id => '',      :text=> 'We suggest that after you enter and accept your birthdate, you select File-Save As from the main menu by using your mouse (or by typing Alt+F, A).  Give the file a brief name and save it.  From then on, if you start a new case either during this session or later, your birthdate will be the default.')
   @Tip_1AtTimeContinue_CS         =WebTip.create!(:identifier => 'Tip_1AtTimeContinue_CS',         :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '5.00',     :workbook_order => '5', :web_numerical_result_id => '',      :text=> 'When all of the answers are correct for your current situation, you can select the Continue button to go on to the next set of questions.  NOTE: The Continue button does not work until you have accepted the answer to the last question in the group.')
   @Tip_GroupContinue              =WebTip.create!(:identifier => 'Tip_GroupContinue',              :display_rules => 'false',        :group_id => @UserInformation,      :group_order => '6.00',     :workbook_order => '6', :web_numerical_result_id => '',      :text=> 'When all of the answers are correct for your current situation, you can select the Continue button to go on to the next set of questions.   NOTE: If you have changed any answers from their defaults, the Continue button will not work until you have accepted that and any other changed answer.')
   @Tip_AgeLessThan15              =WebTip.create!(:identifier => 'Tip_AgeLessThan15',              :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '7.00',     :workbook_order => '7', :web_numerical_result_id => '',      :text=> 'Choose a Situation Date when you will be at least 15 years old.  WW-Web does not calculate results for those who have not reached age 15.')
   @Tip_AgeGreaterThan65           =WebTip.create!(:identifier => 'Tip_AgeGreaterThan65',           :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '8.00',     :workbook_order => '8', :web_numerical_result_id => '',      :text=> 'The current version of WW-Web does not calculate results if you are 66 years old or older.')
   @Tip_SitdateFuture              =WebTip.create!(:identifier => 'Tip_SitdateFuture',              :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '9.00',     :workbook_order => '9', :web_numerical_result_id => '',      :text=> 'Since your "Situation Date" is one or more months in the future, you should be aware that some benefit rates may change by then.  WW-Web uses current rates to calculate results.  The actual results may therefore be off by a few dollars.')
   @Tip_StateNotVirginia           =WebTip.create!(:identifier => 'Tip_StateNotVirginia',           :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '10.00',    :workbook_order => '10', :web_numerical_result_id => '',     :text=> 'This version of WW-Web calculates results only if you live in the Commonwealth of Virginia.  If you would like WW-Web to work for your state, let your state disability agencies know.  They can visit www.workworld.org for information and to contact us.')
   @Tip_NotBlindOrDisabled         =WebTip.create!(:identifier => 'Tip_NotBlindOrDisabled',         :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '11.00',    :workbook_order => '11', :web_numerical_result_id => '',     :text=> 'This version of WW-Web gives correct results only if you are blind or have another type of disability according to the Social Security Administration rules.')
   @Tip_Blind                      =WebTip.create!(:identifier => 'Tip_Blind',                      :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '12.00',    :workbook_order => '12', :web_numerical_result_id => '',     :text=> 'Since you are considered blind according to the SSA definition, you can be eligible for SSI even if you engage in Substantial Gainful Activity (SGA) as long as you meet other eligibility criteria.')
   @Tip_DisabledNotBlind           =WebTip.create!(:identifier => 'Tip_DisabledNotBlind',           :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '13.00',    :workbook_order => '13', :web_numerical_result_id => '',     :text=> 'Since you  are not considered blind according to the SSA definition, if you engage in Substantial Gainful Activity (SGA) within the first 12 months after the onset of your disability, you may be determined NOT ELIGIBLE for SSI even if your SSI payments have already begun. (SSA determines your disability onset date.)')
   @Tip_BPQY                       =WebTip.create!(:identifier => 'Tip_BPQY',                       :display_rules => 'true',         :group_id => @UserInformation,      :group_order => '14.00',    :workbook_order => '14', :web_numerical_result_id => '',     :text=> 'You may be able to answer WW-Web questions without a BPQY, but it can be very helpful.  The WW-Web BPQY help topic explains it and tells you exactly how to get a copy for yourself.')
   @Tip_NotMarried                 =WebTip.create!(:identifier => 'Tip_NotMarried',                 :display_rules => 'true',         :group_id => @HouseholdInfo,        :group_order => '1.00',     :workbook_order => '15', :web_numerical_result_id => '',     :text=> 'Even if you are not legally married, SSA may consider you married if you are living with a person of the opposite sex and the two of you are holding yourself out to the community as married.')
   @Tip_LiveWithOthers             =WebTip.create!(:identifier => 'Tip_LiveWithOthers',             :display_rules => 'true',         :group_id => @HouseholdInfo,        :group_order => '2.00',     :workbook_order => '16', :web_numerical_result_id => '',     :text=> 'Living with others, whether you are married or not, can affect your SSI and Medicaid benefits.  WW-Web will give you specific tips based on whether you are married, on whether you are a student, on your age, and on the benefits you receive.')
   @Tip_SsiAloneAge22              =WebTip.create!(:identifier => 'Tip_SsiAloneAge22',              :display_rules => 'true',         :group_id => @SSI,                  :group_order => '1.00',     :workbook_order => '17', :web_numerical_result_id => '',     :text=> 'Since you live alone the maximum amount of your SSI benefit is $674.00. Your SSI cash benefit will be less if you have other income.  You may, however, be able to use work incentives to decrease or even eliminate the decrease in benefits.  After you enter information about your income and expenses, WW-Web will tell you which work incentives may work best in your situation.')
   @Tip_SsiAgeLessThan22           =WebTip.create!(:identifier => 'Tip_SsiAgeLessThan22',           :display_rules => 'true',         :group_id => @SSI,                  :group_order => '2.00',     :workbook_order => '18', :web_numerical_result_id => '',     :text=> 'Since you will be less than 22 years old on the date of this situation, if you are also a full-time student you can exclude up to $1,640.00 of earned income annually when determining if your SSI cash benefit decreases because of earnings.')
   @Tip_NoFinalDetermination       =WebTip.create!(:identifier => 'Tip_NoFinalDetermination',       :display_rules => 'true',         :group_id => @SSI,                  :group_order => '3.00',     :workbook_order => '19', :web_numerical_result_id => '',     :text=> 'Even if you are receiving SSI cash benefits, if you have not received a letter from SSA saying that you are eligible for SSI, then earning more than SGA ($1,000.00) could cause SSA to cancel your eligibility for SSI.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.')
   @Tip_Ssi_OnsetLessThan12Mo      =WebTip.create!(:identifier => 'Tip_Ssi_OnsetLessThan12Mo',          :display_rules => 'true',         :group_id => @SSI,                  :group_order => '4.00',     :workbook_order => '21', :web_numerical_result_id => '',     :text=> 'Even if you have received a letter from SSA saying that you are eligible for SSI, SSA may cancel your eligibility if you earn more than SGA before 12 months have passed since the onset date of your disability.  SSA says what date is your onset date.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.')
   @Tip_1619b                      =WebTip.create!(:identifier => 'Tip_1619b',                      :display_rules => 'true',         :group_id => @Medicaid,             :group_order => '1.00',     :workbook_order => '22', :web_numerical_result_id => '',     :text=> 'If your earnings go up enough to make your SSI cash benefit go down to zero, then you should continue to be eligible for Medicaid under a program called 1619b -- unless your unearned income or resources have gone up enough to make you ineligible. ')
   @Tip_Ssdi_OnsetLessThan12Mo     =WebTip.create!(:identifier => 'Tip_Ssdi_OnsetLessThan12Mo',     :display_rules => 'true',         :group_id => @SSDI,                 :group_order => '1.00',     :workbook_order => '23', :web_numerical_result_id => '',     :text=> 'Even if you are receiving SSDI cash benefits, SSA may cancel your eligibility if you earn more than SGA before 12 months have passed since the onset date of your disability.  SSA says what date is your onset date.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.')
   @Tip_Ssdi_OwnEarnRecord         =WebTip.create!(:identifier => 'Tip_Ssdi_OwnEarnRecord',         :display_rules => 'true',         :group_id => @SSDI,                 :group_order => '2.00',     :workbook_order => '24', :web_numerical_result_id => '',     :text=> 'If your SSDI eligibility and amount are based on your own past earnings, then any dependents you have may also be eligible for payments.  Do not count their cash benefits as your income unless WW-Web specifically asks you to do so.  You should be aware that if you become ineligible for SSDI, payments to your dependents will stop.')
   @Tip_Ssdi_OtherEarnRecord       =WebTip.create!(:identifier => 'Tip_Ssdi_OtherEarnRecord',       :display_rules => 'true',         :group_id => @SSDI,                 :group_order => '3.00',     :workbook_order => '25', :web_numerical_result_id => '',     :text=> "If your SSDI eligibility and amount are based on someone else's past earnings, then any dependents you have will probably not be eligible for payments.  SSA probably calls you a Disabled Adult Child (DAC), which means that one or both of your parents are disabled or deceased.  If your disabled parent loses SSDI eligibility, then you also may lose your DAC eligibility.")
   @Tip_Ssdi_Sga54to65             =WebTip.create!(:identifier => 'Tip_Ssdi_Sga54to65',             :display_rules => 'true',         :group_id => @SSDI,                 :group_order => '4.00',     :workbook_order => '26', :web_numerical_result_id => '',     :text=> 'If you are blind, between the ages of 54 and 65, and earning more than SGA, you will not lose eligibility for SSDI as long as your skills and abilities are different from what they were before age 55 or before the onset of blindness, whichever is later.  During your Extended Period of Eligibility (EPE) your SSDI cash payment will stop in SGA months, but your EPE will not cease.')
   @Tip_CareBPremiumDeduct         =WebTip.create!(:identifier => 'Tip_CareBPremiumDeduct',         :display_rules => 'true',         :group_id => @Medicare,             :group_order => '1.00',     :workbook_order => '27', :web_numerical_result_id => '',     :text=> 'Your Medicare Part B premium is not deducted from your SSDI cash payment if you have some form of Medicaid that pays the premium.  It is also not deducted if your SSDI cash payment is zero because you earn over the SGA amount.  In that case you must pay the premium out-of-pocket.')
   @Tip_CareBPremiumAmt            =WebTip.create!(:identifier => 'Tip_CareBPremiumAmt',            :display_rules => 'true',         :group_id => @Medicare,             :group_order => '2.00',     :workbook_order => '28', :web_numerical_result_id => '',     :text=> 'If Medicaid is paying your Part B Premium, it is likely that you do not know how much your premium is.  You can accept the default until you find out the correct amount from SSA or your Medicare agency.  If the default is off by a few dollars, it will only make a difference in the actual SSDI cash amount that you would receive if you lose your Medicaid coverage.')

#so i added them manually to heroku and locally and with use the find to update
   @Tip_SwitchToGroup_CS           =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_SwitchToGroup_CS'])
   @Tip_SwitchTo1atTime_CS         =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_SwitchTo1atTime_CS'])         
   @Tip_Birthdate_CS               =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_Birthdate_CS'])               
   @Tip_SaveBirthdate_CS           =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_SaveBirthdate_CS'])           
   @Tip_1AtTimeContinue_CS         =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_1AtTimeContinue_CS'])         
   @Tip_GroupContinue              =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_GroupContinue'])              
   @Tip_AgeLessThan15              =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_AgeLessThan15'])              
   @Tip_AgeGreaterThan65           =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_AgeGreaterThan65'])           
   @Tip_SitdateFuture              =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_SitdateFuture'])              
   @Tip_StateNotVirginia           =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_StateNotVirginia'])           
   @Tip_NotBlindOrDisabled         =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_NotBlindOrDisabled'])         
   @Tip_Blind                      =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_Blind'])                      
   @Tip_DisabledNotBlind           =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_DisabledNotBlind'])           
   @Tip_BPQY                       =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_BPQY'])                       
   @Tip_NotMarried                 =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_NotMarried'])                 
   @Tip_LiveWithOthers             =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_LiveWithOthers'])             
   @Tip_SsiAloneAge22              =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_SsiAloneAge22'])              
   @Tip_SsiAgeLessThan22           =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_SsiAgeLessThan22'])           
   @Tip_NoFinalDetermination       =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_NoFinalDetermination'])       
   @Tip_Ssi_OnsetLessThan12Mo      =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_Ssi_OnsetLessThan12Mo'])          
   @Tip_1619b                      =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_1619b'])                     
   @Tip_Ssdi_OnsetLessThan12Mo     =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_Ssdi_OnsetLessThan12Mo'])     
   @Tip_Ssdi_OwnEarnRecord         =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_Ssdi_OwnEarnRecord'])         
   @Tip_Ssdi_OtherEarnRecord       =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_Ssdi_OtherEarnRecord'])       
   @Tip_Ssdi_Sga54to65             =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_Ssdi_Sga54to65'])             
   @Tip_CareBPremiumDeduct         =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_CareBPremiumDeduct'])         
   @Tip_CareBPremiumAmt            =WebTip.find(:first, :conditions => ['identifier = ?', 'Tip_CareBPremiumAmt'])   
 
 # @web_tip_tip1.update_attribute(:group_id, '63855') unless @web_tip_tip1.blank?  
    @Tip_SwitchToGroup_CS.update_attribute(:text, 'You must first answer questions about your current situation.   WW-Web is showing you questions one at a time.  You must accept each answer before the next question will appear.  If you would rather see all of the questions in each section at once, select the "Switch to group mode" link above the questions and User Information title.') unless @Tip_SwitchToGroup_CS.blank?
    @Tip_SwitchTo1atTime_CS.update_attribute(:text, 'You must first answer questions about your current situation.   WW-Web is showing you questions in group mode.   You can select (click on or tab into) the answers to any of the questions on this page if you want to change them from the default answers.   If you would rather see each question one at a time, select the "Switch to One-at-a-time mode" link above the questions and User Information title.') unless @Tip_SwitchTo1atTime_CS.blank?        
    @Tip_Birthdate_CS.update_attribute(:text, 'Enter your birthdate either by typing MM/DD/YEAR or my clicking on the calendar icon.  Then you can accept your answer by clicking on the Accept button or by hitting the <Tab> key and then <Enter>.') unless @Tip_Birthdate_CS.blank?              
    @Tip_SaveBirthdate_CS.update_attribute(:text, 'We suggest that after you enter and accept your birthdate, you select File-Save As from the main menu by using your mouse (or by typing Alt+F, A).  Give the file a brief name and save it.  From then on, if you start a new case either during this session or later, your birthdate will be the default.') unless @Tip_SaveBirthdate_CS.blank?             
    @Tip_1AtTimeContinue_CS.update_attribute(:text, 'When all of the answers are correct for your current situation, you can select the Continue button to go on to the next set of questions.   NOTE:  The Continue button does not work until you have accepted the answer to the last question in the group.') unless @Tip_1AtTimeContinue_CS.blank?             
    @Tip_GroupContinue.update_attribute(:text, 'When all of the answers are correct for your current situation, you can select the Continue button to go on to the next set of questions.   NOTE:  If you have changed any answers from their defaults, the Continue button will not work until you have accepted that and any other changed answer.') unless @Tip_GroupContinue.blank?             
    @Tip_AgeLessThan15.update_attribute(:text, 'Choose a Situation Date when you will be at least 15 years old.  WW-Web does not calculate results for those who have not reached age 15.') unless @Tip_AgeLessThan15.blank?             
    @Tip_AgeGreaterThan65.update_attribute(:text, 'The current version of WW-Web does not calculate results if you are 66 years old or older.') unless @Tip_AgeGreaterThan65.blank?             
    @Tip_SitdateFuture.update_attribute(:text, 'Since your "Situation Date" is one or more months in the future, you should e aware that some benefit rates may change by then.  WW-Web uses current rates to calculate results.  The actual results may therefore be off by a few dollars.') unless @Tip_SitdateFuture.blank?             
    @Tip_StateNotVirginia.update_attribute(:text, 'This version of WW-Web calculates results only if you live in the Commonwealth of Virginia.  If you would like WW-Web to work for your state, let your state disability agencies know.  They can visit www.workworld.org for information and to contact us.') unless @Tip_StateNotVirginia.blank?                              
    @Tip_NotBlindOrDisabled.update_attribute(:text, "This version of WW-Web gives correct results only if you are blind or have another type of disability according to the Social Security Administration's rules.") unless @Tip_NotBlindOrDisabled.blank?                              
    @Tip_Blind.update_attribute(:text, 'Since you are considered blind according to the SSA definition, you can be eligible for SSI even if you engage in Substantial Gainful Activity (SGA) as long as you meet other eligibility criteria.') unless @Tip_Blind.blank?                              
    @Tip_DisabledNotBlind.update_attribute(:text, 'Since you are not considered blind according to the SSA definition, if you engage in Substantial Gainful Activity (SGA) within the first 12 months after the onset of your disability, you may be determined NOT ELIGIBLE for SSI even if your SSI payments have already begun. (SSA determines your disability onset date.)') unless @Tip_DisabledNotBlind.blank?                              
    @Tip_BPQY.update_attribute(:text, 'You may be able to answer WW-Web questions without a BPQY, but it can be very helpful.  The WW-Web BPQY help topic explains it and tells you exactly how to get a copy for yourself.') unless @Tip_BPQY.blank?                              
    @Tip_NotMarried.update_attribute(:text, 'Even if you are not legally married, SSA may consider you married if you are living with a person of the opposite sex and the two of you are holding yourself out to the community as married. ') unless @Tip_NotMarried.blank?                              
    @Tip_LiveWithOthers.update_attribute(:text, 'Living with others, whether you are married or not, can affect your SSI and Medicaid benefits.  WW-Web will give you specific tips based on whether you are married, on whether you are a student, on your age, and on the benefits you receive.') unless @Tip_LiveWithOthers.blank?                              
    @Tip_SsiAloneAge22.update_attribute(:text, 'Since you live alone the maximum amount of your SSI benefit is $674.00.  Your SSI cash benefit will be less if you have other income.  You may, however, be able to use work incentives to decrease or even eliminate the decrease in benefits.  After you enter information about your income and expenses, WW-Web will tell you which work incentives may work best in your situation.') unless @Tip_SsiAloneAge22.blank?                              
    @Tip_SsiAgeLessThan22.update_attribute(:text, 'Since you will be less than 22 years old on the date of this situation, if you are also a full-time student you can exclude up to $1,640.00 of earned income annually when determining if your SSI cash benefit decreases because of earnings.') unless @Tip_SsiAgeLessThan22.blank?                              
    @Tip_NoFinalDetermination.update_attribute(:text, 'Even if you are receiving SSI cash benefits, if you have not received a letter from SSA saying that you are eligible for SSI, then earning more than SGA could cause SSA to cancel your eligibility for SSI.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.') unless @Tip_NoFinalDetermination.blank?
    @Tip_Ssi_OnsetLessThan12Mo.update_attribute(:text, 'Even if you have received a letter from SSA saying that you are eligible for SSI, SSA may cancel your eligibility if you earn more than SGA ($1,000.00) before 12 months have passed since the onset date of your disability.  SSA says what date is your onset date.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility."') unless @Tip_Ssi_OnsetLessThan12Mo.blank?                              
    @Tip_1619b.update_attribute(:text, 'If your earnings go up enough to make your SSI cash benefit go down to zero, then you should continue to be eligible for Medicaid under a program called 1619b -- unless your unearned income or resources have gone up enough to make you ineligible. ') unless @Tip_1619b.blank?                              
    @Tip_Ssdi_OnsetLessThan12Mo.update_attribute(:text, 'Even if you are receiving SSDI cash benefits, SSA may cancel your eligibility if you earn more than SGA ($1,000.00) before 12 months have passed since the onset date of your disability.  SSA says what date is your onset date.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.') unless @Tip_Ssdi_OnsetLessThan12Mo.blank?                              
    @Tip_Ssdi_OwnEarnRecord.update_attribute(:text, 'If your SSDI eligibility and amount are based on your own past earnings, then any dependents you have may also be eligible for payments.  Do not count their cash benefits as your income unless WW-Web specifically asks you to do so.  You should be aware that if you become ineligible for SSDI, payments to your dependents will stop.') unless @Tip_Ssdi_OwnEarnRecord.blank?                              
    @Tip_Ssdi_OtherEarnRecord.update_attribute(:text, "If your SSDI eligibility and amount are based on someone else's past earnings, then any dependents you have will probably not be eligible for payments.  SSA probably calls you a Disabled Adult Child (DAC), which means that one or both of your parents are disabled or deceased.  If your disabled parent loses SSDI eligibility, then you also may lose your DAC eligibility.") unless @Tip_Ssdi_OtherEarnRecord.blank?                              
    @Tip_Ssdi_Sga54to65.update_attribute(:text, 'If you are blind, between the ages of 54 and 65, and earning more than SGA, you will not lose eligibility for SSDI as long as your skills and abilities are different from what they were before age 55 or before the onset of blindness, whichever is later.  During your Extended Period of Eligibility (EPE) your SSDI cash payment will stop in SGA months, but your EPE will not cease.') unless @Tip_Ssdi_Sga54to65.blank?                              
    @Tip_CareBPremiumDeduct.update_attribute(:text, 'Your Medicare Part B premium is not deducted from your SSDI cash payment if you have some form of Medicaid that pays the premium.  It is also not deducted if your SSDI cash payment is zero because you earn over the SGA amount.  In that case you must pay the premium out-of-pocket.') unless @Tip_CareBPremiumDeduct.blank?                              
    @Tip_CareBPremiumAmt.update_attribute(:text, 'If Medicaid is paying your Part B Premium, it is likely that you do not know how much your premium is.  You can accept the default until you find out the correct amount from SSA or your Medicare agency.  If the default is off by a few dollars, it will only make a difference in the actual SSDI cash amount that you would receive if you lose your Medicaid coverage.') unless @Tip_CareBPremiumAmt.blank?                              
 
 
    @Tip_SwitchToGroup_CS.update_attribute(:display_rules, 'false') unless @Tip_SwitchToGroup_CS.blank?
    @Tip_SwitchTo1atTime_CS.update_attribute(:display_rules, 'false') unless @Tip_SwitchTo1atTime_CS.blank?        
    @Tip_Birthdate_CS.update_attribute(:display_rules, 'false') unless @Tip_Birthdate_CS.blank?              
    @Tip_SaveBirthdate_CS.update_attribute(:display_rules, 'false') unless @Tip_SaveBirthdate_CS.blank?             
    @Tip_1AtTimeContinue_CS.update_attribute(:display_rules, 'false') unless @Tip_1AtTimeContinue_CS.blank?             
    @Tip_GroupContinue.update_attribute(:display_rules, 'false') unless @Tip_GroupContinue.blank?             
    @Tip_AgeLessThan15.update_attribute(:display_rules, 'false') unless @Tip_AgeLessThan15.blank?             
    @Tip_AgeGreaterThan65.update_attribute(:display_rules, 'false') unless @Tip_AgeGreaterThan65.blank?             
    @Tip_SitdateFuture.update_attribute(:display_rules, 'false') unless @Tip_SitdateFuture.blank?             
    @Tip_StateNotVirginia.update_attribute(:display_rules, 'false') unless @Tip_StateNotVirginia.blank?                              
    @Tip_NotBlindOrDisabled.update_attribute(:display_rules, 'false') unless @Tip_NotBlindOrDisabled.blank?                              
    @Tip_Blind.update_attribute(:display_rules, 'false') unless @Tip_Blind.blank?                              
    @Tip_DisabledNotBlind.update_attribute(:display_rules, 'false') unless @Tip_DisabledNotBlind.blank?                              
    @Tip_BPQY.update_attribute(:display_rules, 'false') unless @Tip_BPQY.blank?                              
    @Tip_NotMarried.update_attribute(:display_rules, 'false') unless @Tip_NotMarried.blank?                              
    @Tip_LiveWithOthers.update_attribute(:display_rules, 'false') unless @Tip_LiveWithOthers.blank?                              
    @Tip_SsiAloneAge22.update_attribute(:display_rules, 'false') unless @Tip_SsiAloneAge22.blank?                              
    @Tip_SsiAgeLessThan22.update_attribute(:display_rules, 'false') unless @Tip_SsiAgeLessThan22.blank?                              
    @Tip_NoFinalDetermination.update_attribute(:display_rules, 'false') unless @Tip_NoFinalDetermination.blank?                              
    @Tip_Ssi_OnsetLessThan12Mo.update_attribute(:display_rules, 'false') unless @Tip_Ssi_OnsetLessThan12Mo.blank?                              
    @Tip_1619b.update_attribute(:display_rules, 'false') unless @Tip_1619b.blank?                              
    @Tip_Ssdi_OnsetLessThan12Mo.update_attribute(:display_rules, 'false') unless @Tip_Ssdi_OnsetLessThan12Mo.blank?                              
    @Tip_Ssdi_OwnEarnRecord.update_attribute(:display_rules, 'false') unless @Tip_Ssdi_OwnEarnRecord.blank?                              
    @Tip_Ssdi_OtherEarnRecord.update_attribute(:display_rules, 'false') unless @Tip_Ssdi_OtherEarnRecord.blank?                              
    @Tip_Ssdi_Sga54to65.update_attribute(:display_rules, 'false') unless @Tip_Ssdi_Sga54to65.blank?                              
    @Tip_CareBPremiumDeduct.update_attribute(:display_rules, 'false') unless @Tip_CareBPremiumDeduct.blank?                              
    @Tip_CareBPremiumAmt.update_attribute(:display_rules, 'false') unless @Tip_CareBPremiumAmt.blank?                                                                                                          
 
 #   @UserInformation = '63855'
 #    @HouseholdInfo = '63856'
 #    @SSI = '63858'
 #    @Medicaid = '63859'
 #    @SSDI = '63860'
 #    @Medicare = '63861'
     
    @Tip_SwitchToGroup_CS.update_attribute(:group_id, @UserInformation) unless @Tip_SwitchToGroup_CS.blank?
    @Tip_SwitchTo1atTime_CS.update_attribute(:group_id, @UserInformation) unless @Tip_SwitchTo1atTime_CS.blank?        
    @Tip_Birthdate_CS.update_attribute(:group_id, @UserInformation) unless @Tip_Birthdate_CS.blank?              
    @Tip_SaveBirthdate_CS.update_attribute(:group_id, @UserInformation) unless @Tip_SaveBirthdate_CS.blank?             
    @Tip_1AtTimeContinue_CS.update_attribute(:group_id, @UserInformation) unless @Tip_1AtTimeContinue_CS.blank?             
    @Tip_GroupContinue.update_attribute(:group_id, @UserInformation) unless @Tip_GroupContinue.blank?             
    @Tip_AgeLessThan15.update_attribute(:group_id, @UserInformation) unless @Tip_AgeLessThan15.blank?             
    @Tip_AgeGreaterThan65.update_attribute(:group_id, @UserInformation) unless @Tip_AgeGreaterThan65.blank?             
    @Tip_SitdateFuture.update_attribute(:group_id, @UserInformation) unless @Tip_SitdateFuture.blank?             
    @Tip_StateNotVirginia.update_attribute(:group_id, @UserInformation) unless @Tip_StateNotVirginia.blank?                              
    @Tip_NotBlindOrDisabled.update_attribute(:group_id, @UserInformation) unless @Tip_NotBlindOrDisabled.blank?                              
    @Tip_Blind.update_attribute(:group_id, @UserInformation) unless @Tip_Blind.blank?                              
    @Tip_DisabledNotBlind.update_attribute(:group_id, @UserInformation) unless @Tip_DisabledNotBlind.blank?                              
    @Tip_BPQY.update_attribute(:group_id, @UserInformation) unless @Tip_BPQY.blank?                              
    @Tip_NotMarried.update_attribute(:group_id, @HouseholdInfo) unless @Tip_NotMarried.blank?                              
    @Tip_LiveWithOthers.update_attribute(:group_id, @HouseholdInfo) unless @Tip_LiveWithOthers.blank?                              
    @Tip_SsiAloneAge22.update_attribute(:group_id, @SSI) unless @Tip_SsiAloneAge22.blank?                              
    @Tip_SsiAgeLessThan22.update_attribute(:group_id, @SSI) unless @Tip_SsiAgeLessThan22.blank?                              
    @Tip_NoFinalDetermination.update_attribute(:group_id, @SSI) unless @Tip_NoFinalDetermination.blank?                              
    @Tip_Ssi_OnsetLessThan12Mo.update_attribute(:group_id, @SSI) unless @Tip_Ssi_OnsetLessThan12Mo.blank?                              
    @Tip_1619b.update_attribute(:group_id, @Medicaid) unless @Tip_1619b.blank?                              
    @Tip_Ssdi_OnsetLessThan12Mo.update_attribute(:group_id, @SSDI) unless @Tip_Ssdi_OnsetLessThan12Mo.blank?                              
    @Tip_Ssdi_OwnEarnRecord.update_attribute(:group_id, @SSDI) unless @Tip_Ssdi_OwnEarnRecord.blank?                              
    @Tip_Ssdi_OtherEarnRecord.update_attribute(:group_id, @SSDI) unless @Tip_Ssdi_OtherEarnRecord.blank?                              
    @Tip_Ssdi_Sga54to65.update_attribute(:group_id, @SSDI) unless @Tip_Ssdi_Sga54to65.blank?                              
    @Tip_CareBPremiumDeduct.update_attribute(:group_id, @Medicare) unless @Tip_CareBPremiumDeduct.blank?                              
    @Tip_CareBPremiumAmt.update_attribute(:group_id, @Medicare) unless @Tip_CareBPremiumAmt.blank?
    
    @Tip_SwitchToGroup_CS.update_attribute(:group_order, '1') unless @Tip_SwitchToGroup_CS.blank?
    @Tip_SwitchTo1atTime_CS.update_attribute(:group_order, '2') unless @Tip_SwitchTo1atTime_CS.blank?        
    @Tip_Birthdate_CS.update_attribute(:group_order, '3') unless @Tip_Birthdate_CS.blank?              
    @Tip_SaveBirthdate_CS.update_attribute(:group_order, '4') unless @Tip_SaveBirthdate_CS.blank?             
    @Tip_1AtTimeContinue_CS.update_attribute(:group_order, '5') unless @Tip_1AtTimeContinue_CS.blank?             
    @Tip_GroupContinue.update_attribute(:group_order, '6') unless @Tip_GroupContinue.blank?             
    @Tip_AgeLessThan15.update_attribute(:group_order, '7') unless @Tip_AgeLessThan15.blank?             
    @Tip_AgeGreaterThan65.update_attribute(:group_order, '8') unless @Tip_AgeGreaterThan65.blank?             
    @Tip_SitdateFuture.update_attribute(:group_order, '9') unless @Tip_SitdateFuture.blank?             
    @Tip_StateNotVirginia.update_attribute(:group_order, '10') unless @Tip_StateNotVirginia.blank?                              
    @Tip_NotBlindOrDisabled.update_attribute(:group_order, '11') unless @Tip_NotBlindOrDisabled.blank?                              
    @Tip_Blind.update_attribute(:group_order, '12') unless @Tip_Blind.blank?                              
    @Tip_DisabledNotBlind.update_attribute(:group_order, '13') unless @Tip_DisabledNotBlind.blank?                              
    @Tip_BPQY.update_attribute(:group_order, '14') unless @Tip_BPQY.blank?                              
    @Tip_NotMarried.update_attribute(:group_order, '15') unless @Tip_NotMarried.blank?                              
    @Tip_LiveWithOthers.update_attribute(:group_order, '16') unless @Tip_LiveWithOthers.blank?                              
    @Tip_SsiAloneAge22.update_attribute(:group_order, '1') unless @Tip_SsiAloneAge22.blank?                              
    @Tip_SsiAgeLessThan22.update_attribute(:group_order, '2') unless @Tip_SsiAgeLessThan22.blank?                              
    @Tip_NoFinalDetermination.update_attribute(:group_order, '3') unless @Tip_NoFinalDetermination.blank?                              
    @Tip_Ssi_OnsetLessThan12Mo.update_attribute(:group_order, '4') unless @Tip_Ssi_OnsetLessThan12Mo.blank?                              
    @Tip_1619b.update_attribute(:group_order, '1') unless @Tip_1619b.blank?                              
    @Tip_Ssdi_OnsetLessThan12Mo.update_attribute(:group_order, '1') unless @Tip_Ssdi_OnsetLessThan12Mo.blank?                              
    @Tip_Ssdi_OwnEarnRecord.update_attribute(:group_order, '2') unless @Tip_Ssdi_OwnEarnRecord.blank?                              
    @Tip_Ssdi_OtherEarnRecord.update_attribute(:group_order, '3') unless @Tip_Ssdi_OtherEarnRecord.blank?                              
    @Tip_Ssdi_Sga54to65.update_attribute(:group_order, '4') unless @Tip_Ssdi_Sga54to65.blank?                              
    @Tip_CareBPremiumDeduct.update_attribute(:group_order, '1') unless @Tip_CareBPremiumDeduct.blank?                              
    @Tip_CareBPremiumAmt.update_attribute(:group_order, '2') unless @Tip_CareBPremiumAmt.blank?
    
     @Tip_SwitchToGroup_CS.update_attribute(:workbook_order, '1') unless @Tip_SwitchToGroup_CS.blank?
     @Tip_SwitchTo1atTime_CS.update_attribute(:workbook_order, '2') unless @Tip_SwitchTo1atTime_CS.blank?        
     @Tip_Birthdate_CS.update_attribute(:workbook_order, '3') unless @Tip_Birthdate_CS.blank?              
     @Tip_SaveBirthdate_CS.update_attribute(:workbook_order, '4') unless @Tip_SaveBirthdate_CS.blank?             
     @Tip_1AtTimeContinue_CS.update_attribute(:workbook_order, '5') unless @Tip_1AtTimeContinue_CS.blank?             
     @Tip_GroupContinue.update_attribute(:workbook_order, '6') unless @Tip_GroupContinue.blank?             
     @Tip_AgeLessThan15.update_attribute(:workbook_order, '7') unless @Tip_AgeLessThan15.blank?             
     @Tip_AgeGreaterThan65.update_attribute(:workbook_order, '8') unless @Tip_AgeGreaterThan65.blank?             
     @Tip_SitdateFuture.update_attribute(:workbook_order, '9') unless @Tip_SitdateFuture.blank?             
     @Tip_StateNotVirginia.update_attribute(:workbook_order, '10') unless @Tip_StateNotVirginia.blank?                              
     @Tip_NotBlindOrDisabled.update_attribute(:workbook_order, '11') unless @Tip_NotBlindOrDisabled.blank?                              
     @Tip_Blind.update_attribute(:workbook_order, '12') unless @Tip_Blind.blank?                              
     @Tip_DisabledNotBlind.update_attribute(:workbook_order, '13') unless @Tip_DisabledNotBlind.blank?                              
     @Tip_BPQY.update_attribute(:workbook_order, '14') unless @Tip_BPQY.blank?                              
     @Tip_NotMarried.update_attribute(:workbook_order, '15') unless @Tip_NotMarried.blank?                              
     @Tip_LiveWithOthers.update_attribute(:workbook_order, '16') unless @Tip_LiveWithOthers.blank?                              
     @Tip_SsiAloneAge22.update_attribute(:workbook_order, '17') unless @Tip_SsiAloneAge22.blank?                              
     @Tip_SsiAgeLessThan22.update_attribute(:workbook_order, '18') unless @Tip_SsiAgeLessThan22.blank?                              
     @Tip_NoFinalDetermination.update_attribute(:workbook_order, '19') unless @Tip_NoFinalDetermination.blank?                              
     @Tip_Ssi_OnsetLessThan12Mo.update_attribute(:workbook_order, '20') unless @Tip_Ssi_OnsetLessThan12Mo.blank?                              
     @Tip_1619b.update_attribute(:workbook_order, '21') unless @Tip_1619b.blank?                              
     @Tip_Ssdi_OnsetLessThan12Mo.update_attribute(:workbook_order, '22') unless @Tip_Ssdi_OnsetLessThan12Mo.blank?                              
     @Tip_Ssdi_OwnEarnRecord.update_attribute(:workbook_order, '23') unless @Tip_Ssdi_OwnEarnRecord.blank?                              
     @Tip_Ssdi_OtherEarnRecord.update_attribute(:workbook_order, '24') unless @Tip_Ssdi_OtherEarnRecord.blank?                              
     @Tip_Ssdi_Sga54to65.update_attribute(:workbook_order, '25') unless @Tip_Ssdi_Sga54to65.blank?                              
     @Tip_CareBPremiumDeduct.update_attribute(:workbook_order, '26') unless @Tip_CareBPremiumDeduct.blank?                              
     @Tip_CareBPremiumAmt.update_attribute(:workbook_order, '27') unless @Tip_CareBPremiumAmt.blank? 
  
  end

  def self.down
  end
end
