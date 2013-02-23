class ModifySsiOrCaidEarnAmtForDisplayRuleLiveWithSpouseWrinke < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
    
    #25	103	How much do you Receive monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]	SsiOrCaidEarnAmt			Zero or Positive Number 	Enter positive numbers only.  Do not enter $.	EXPRESSION: $0.00 OR SsdiEarnAmt	If (SsiGet = Y AND LiveWithSpouse = N AND SsiResourceLimitExceed <> Y) OR (SsiGet = Y AND LiveWithSpouse = Y AND SsiCoupleResourceLimitExceed <> Y) OR ((CaidGet = Y OR CaidApply = Y) AND LiveWithSpouse = N AND CaidMostGroupsResourceLimitExceed <>Y) OR ((CaidGet = Y OR CaidApply = Y) AND  LiveWithSpouse = Y AND CaidCoupleMostGroupsResourceLimitExceed <>Y)	Appear	1,000.00		108.00
   
    @SsiOrCaidEarnAmt = Question.find(:first, :conditions => ['name = ?',  'SsiOrCaidEarnAmt']) 
    
     #If ((CaidGet = Y AND VA_CaidGetCoveredGroup = QDWI)  OR (CaidApply = Y AND VA_CaidApplyCoveredGroup =  QDWI)) AND LiveWithSpouse = N
     @SsiOrCaidEarnAmt.update_attribute(:display_rules, "SsiGet = manager.get_answer_by_question_name('SsiGet')
     LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
     Married = manager.get_answer_by_question_name('Married')
     SsiResourceLimitExceed = manager.get_answer_by_question_name('SsiResourceLimitExceed')
     SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
     CaidGet = manager.get_answer_by_question_name('CaidGet')
     CaidApply = manager.get_answer_by_question_name('CaidApply')
     CaidResourceLimitExceed = manager.get_answer_by_question_name('CaidResourceLimitExceed')
     CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
     (SsiGet == 'Yes' && (Married == 'No' || LiveWithSpouse == 'No') && SsiResourceLimitExceed != 'Yes') || (SsiGet == 'Yes' && LiveWithSpouse == 'Yes' && SsiCoupleResourceLimitExceed != 'Yes') || ((CaidGet == 'Yes' || CaidApply == 'Yes') && LiveWithSpouse == 'No' && CaidResourceLimitExceed !='Yes') || ((CaidGet == 'Yes' || CaidApply == 'Yes') &&  LiveWithSpouse == 'Yes' && CaidCoupleResourceLimitExceed != 'Yes')
     ") unless @SsiOrCaidEarnAmt.blank?
    
  end

  def self.down
  end
end
