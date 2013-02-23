class CreateRSpouseSsiOrCaidEarnAmtAppearWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  

     @RSpouseSsiOrCaidEarnAmtAppear = WebCalc.find_by_name('RSpouseSsiOrCaidEarnAmtAppear')
        if @RSpouseSsiOrCaidEarnAmtAppear.blank? then
          @RSpouseSsiOrCaidEarnAmtAppear  = WebCalc.new(:name => 'RSpouseSsiOrCaidEarnAmtAppear')
        end
  
      #25 47	108	How much monthly income from wages, salary or self-employment does your spouse RECEIVE? [NOTE: Select "Help" for difference between Earn & Receive.] 	SpouseSsiOrCaidEarnAmt			Zero or Positive Number	Enter positive numbers only.  Do not enter $.	0	
      #IF (SpouseSsiGet = Y AND SsiCoupleResourceLimitExceed <> Y) OR ((CaidSpouseGet = Y OR CaidSpouseApply = Y) AND CaidCoupleMostGroupsResourceLimitExceed <> Y)	no	700.00		113.00
        
     @RSpouseSsiOrCaidEarnAmtAppear.operation = "
     SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
     SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
     CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
     CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
     CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
     ((SpouseSsiGet == 'Yes') && SsiCoupleResourceLimitExceed != 'Yes') || ((CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') && CaidCoupleResourceLimitExceed != 'Yes')
     "
      @RSpouseSsiOrCaidEarnAmtAppear.save!
  end

  def self.down
  end
end
