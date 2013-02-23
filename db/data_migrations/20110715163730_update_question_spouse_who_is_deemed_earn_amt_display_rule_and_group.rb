class UpdateQuestionSpouseWhoIsDeemedEarnAmtDisplayRuleAndGroup < ActiveRecord::Migration
  def self.up
    
    #27 30 47 48	135.5	How much earned income does your spouse receive per month?	SpouseLessThan22WhoIsDeemedEarnAmt					0	If SpouseSsiOrCaidEarnAmt Appear Calc <> Appear AND (SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y) AND (SpouseBirthDate - SitDate) < 22 	no		In the deeming section we ask only for the amounts of income that are deemed from a non-SSI, non-Medicaid spouse.  Here, for SEIE calcs, we ask what the earnings are so that we can tell if correct SEIE amounts are being excluded.  (A couple is allowed only the same amount as individual exclusion.)	141.00
    #we are not renaming keeping SpouseWhoIsDeemedEarnAmt here
    
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Earned Income'])
   
     @SpouseWhoIsDeemedEarnAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseWhoIsDeemedEarnAmt']) 
     @SpouseWhoIsDeemedEarnAmt.update_attribute(:group_id, @QuestionGroup.id) unless @SpouseWhoIsDeemedEarnAmt.blank?
     @SpouseWhoIsDeemedEarnAmt.update_attribute(:question_order, "6") unless @SpouseWhoIsDeemedEarnAmt.blank?
     @SpouseWhoIsDeemedEarnAmt.update_attribute(:workbook_order, "115.4") unless @SpouseWhoIsDeemedEarnAmt.blank?
     
     #If SpouseSsiOrCaidEarnAmt Appear Calc <> Appear AND (SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y) AND (SpouseBirthDate - SitDate) < 22 
     #RSpouseSsiOrCaidEarnAmtAppear
    @SpouseWhoIsDeemedEarnAmt.update_attribute(:display_rules, "
    RSpouseSsiOrCaidEarnAmtAppear = WebCalc.find_by_name('RSpouseSsiOrCaidEarnAmtAppear')
    RSpouseSsiOrCaidEarnAmtAppear = (RSpouseSsiOrCaidEarnAmtAppear.calculate manager)
    SsiSpouseDeem = manager.get_answer_by_question_name('SsiSpouseDeem')
    VA_CaidSpouseDeem = manager.get_answer_by_question_name('VA_CaidSpouseDeem')
    RSpouseAge = WebCalc.find_by_name('RSpouseAge')
    RSpouseAge = Float(RSpouseAge.calculate manager)
    (RSpouseSsiOrCaidEarnAmtAppear == false && (SsiSpouseDeem == 'Yes' || VA_CaidSpouseDeem == 'Yes') && RSpouseAge < 22 )")  unless @SpouseWhoIsDeemedEarnAmt.blank?
  
  end

  def self.down
  end
end
