class CreateRSsiResourceLimitExceedWebcalc < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'  

       #323	IF SsiResourceLimitExceed = YES OR SsiCoupleResourceLimitExceed = YES, THEN RSsiResourceLimitExceed = TRUE, ELSE FALSE	RSsiResourceLimitExceed
       
       @RSsiResourceLimitExceed  = WebCalc.new(:name => 'RSsiResourceLimitExceed')
       @RSsiResourceLimitExceed.operation = "
        SsiResourceLimitExceed = manager.get_answer_by_question_name('SsiResourceLimitExceed')
        SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
        if ( SsiResourceLimitExceed == 'Yes' || SsiCoupleResourceLimitExceed == 'Yes' ) then
          true
        else
         false
        end
       "
       @RSsiResourceLimitExceed.save!
       
  end

  def self.down
  end
end
