class CreateRCaidResourceLimitExceedWebcalc < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'  

       #39 41	325	IF (CaidMostGroupsResourceLimitExceed OR CaidCoupleMostGroupsResourceLimitExceed OR CaidQdwiResourceLimitExceed 
       #              or CaidCoupleQdwiResourceLimitExceed OR CaidQmbSlmbQiResourceLimitExceed OR CaidCoupleQmbSlmbQiResourceLimitExceed OR CaidWorksResourceLimitExceed) = YES, 
       #THEN RCaidResourceLimitExceed = TRUE, ELSE FALSE	RCaidResourceLimitExceed
       
       #=IF(OR(F310="YES";F311="YES";F312="YES";F313="YES";F314="YES";F315="YES";F316="YES");1; 0)
       #310 - 316 all questions
       #CaidMostGroupsResourceLimitExceed
       #CaidCoupleMostGroupsResourceLimitExceed
       #CaidQdwiResourceLimitExceed
       #CaidCoupleQdwiResourceLimitExceed
       #CaidQmbSlmbQiResourceLimitExceed
       #CaidCoupleQmbSlmbQiResourceLimitExceed
       #CaidWorksResourceLimitExceed
       
       
       @RCaidResourceLimitExceed  = WebCalc.new(:name => 'RCaidResourceLimitExceed')
       @RCaidResourceLimitExceed.operation = "
       CaidMostGroupsResourceLimitExceed        = manager.get_answer_by_question_name('CaidMostGroupsResourceLimitExceed')
       CaidCoupleMostGroupsResourceLimitExceed  = manager.get_answer_by_question_name('CaidCoupleMostGroupsResourceLimitExceed')
       CaidQdwiResourceLimitExceed              = manager.get_answer_by_question_name('CaidQdwiResourceLimitExceed')
       CaidCoupleQdwiResourceLimitExceed        = manager.get_answer_by_question_name('CaidCoupleQdwiResourceLimitExceed')
       CaidQmbSlmbQiResourceLimitExceed         = manager.get_answer_by_question_name('CaidQmbSlmbQiResourceLimitExceed')
       CaidCoupleQmbSlmbQiResourceLimitExceed   = manager.get_answer_by_question_name('CaidCoupleQmbSlmbQiResourceLimitExceed')
       CaidWorksResourceLimitExceed             = manager.get_answer_by_question_name('CaidWorksResourceLimitExceed')
       if ( CaidMostGroupsResourceLimitExceed == 'Yes' || CaidCoupleMostGroupsResourceLimitExceed == 'Yes' || CaidQdwiResourceLimitExceed == 'Yes' || CaidCoupleQdwiResourceLimitExceed == 'Yes' || 
         CaidQmbSlmbQiResourceLimitExceed == 'Yes'  ||
         CaidCoupleQmbSlmbQiResourceLimitExceed == 'Yes' || 
         CaidWorksResourceLimitExceed == 'Yes') then
          true
        else
         false
        end
       "
       @RCaidResourceLimitExceed.save!
  end

  def self.down
  end
end
