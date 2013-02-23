class UpdateSpouseWhoIsDeemedEarnAmtAndSpouseSsiOrCaidEarnAmtQuestionsIncludingSpouseSsiOrCaidEarnAmtAppearWebcalc < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
    
      @SpouseSsiOrCaidEarnAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSsiOrCaidEarnAmt']) 
      @SpouseSsiOrCaidEarnAmt.update_attribute(:display_rules, "
      RSpouseSsiOrCaidEarnAmtAppear = WebCalc.find_by_name('RSpouseSsiOrCaidEarnAmtAppear')
      RSpouseSsiOrCaidEarnAmtAppear = (RSpouseSsiOrCaidEarnAmtAppear.calculate manager)
      (RSpouseSsiOrCaidEarnAmtAppear  == true)
      ")
       
    #  27 30 47	135.5	How much earned income does your spouse receive per month?	SpouseWhoIsDeemedEarnAmt					
    #0	If SpouseSsiOrCaidEarnAmt Appear Calc <> Appear AND (SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y) 	no		Above we ask only for the amounts of income that are deemed.  Here, for SEIE calcs, we ask what the earnings are so that we can tell if correct SEIE amounts are being excluded.  (A couple is allowed only the same amount as individual exclusion.)	141.00
     
      @SpouseWhoIsDeemedEarnAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseWhoIsDeemedEarnAmt']) 
      @SpouseWhoIsDeemedEarnAmt.update_attribute(:display_rules, "
      RSpouseSsiOrCaidEarnAmtAppear = WebCalc.find_by_name('RSpouseSsiOrCaidEarnAmtAppear')
      RSpouseSsiOrCaidEarnAmtAppear = (RSpouseSsiOrCaidEarnAmtAppear.calculate manager)
      SsiSpouseDeem = manager.get_answer_by_question_name('SsiSpouseDeem')
      VA_CaidSpouseDeem = manager.get_answer_by_question_name('VA_CaidSpouseDeem')
      (RSpouseSsiOrCaidEarnAmtAppear  == false && (SsiSpouseDeem == 'Yes' || VA_CaidSpouseDeem == 'Yes'))
      ") 
      
      @SpouseWhoIsDeemedEarnAmt.update_attribute(:text, "How much earned income does your spouse receive per month?")
   
  end

  def self.down
  end
end
