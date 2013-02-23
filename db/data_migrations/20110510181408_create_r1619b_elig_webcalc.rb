class CreateR1619bEligWebcalc < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  

       #333	IF SsiGet = YES, AND SsiOrCaidEarnAmt > 0, AND R_SsiUserOverUnderAdjustCalcAmt + R_SsiCoupleOverUnderAdjustCalcAmt = 0 AND R1619bIneligUnearnOrResources = FALSE AND R1619bIneligThreshold = FALSE, THEN R1619bElig = TRUE, ELSE FALSE	R1619bElig
       
       @R1619bElig  = WebCalc.new(:name => 'R1619bElig')
       @R1619bElig.operation = "
        SsiGet = manager.get_answer_by_question_name('SsiGet')
        SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
        R_SsiUserOverUnderAdjustCalcAmt = WebCalc.find_by_name('R_SsiUserOverUnderAdjustCalcAmt')
        R_SsiUserOverUnderAdjustCalcAmt = Float(R_SsiUserOverUnderAdjustCalcAmt.calculate manager)
        R_SsiCoupleOverUnderAdjustCalcAmt = WebCalc.find_by_name('R_SsiCoupleOverUnderAdjustCalcAmt')
        R_SsiCoupleOverUnderAdjustCalcAmt = Float(R_SsiCoupleOverUnderAdjustCalcAmt.calculate manager)
        
        R1619bIneligUnearnOrResources = WebCalc.find_by_name('R1619bIneligUnearnOrResources')
        R1619bIneligUnearnOrResources = (R1619bIneligUnearnOrResources.calculate manager)
        R1619bIneligThreshold = WebCalc.find_by_name('R1619bIneligThreshold')
        R1619bIneligThreshold = (R1619bIneligThreshold.calculate manager)
        
        if ( SsiGet == 'Yes' && SsiOrCaidEarnAmt.to_f > 0 && ((R_SsiUserOverUnderAdjustCalcAmt + R_SsiCoupleOverUnderAdjustCalcAmt) == 0) && R1619bIneligUnearnOrResources == false && R1619bIneligThreshold == false) then
          true
        else
         false
        end
       "
       @R1619bElig.save!
  end

  def self.down
  end
end
