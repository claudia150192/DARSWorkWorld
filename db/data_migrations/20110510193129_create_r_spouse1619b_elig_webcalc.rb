class CreateRSpouse1619bEligWebcalc < ActiveRecord::Migration
  def self.up
  require 'wwweb_session_manager'  
 
    #335	IF SpouseSsiGet = YES, AND SpouseSsiOrCaidEarnAmt > 0, AND R_SsiCoupleOverUnderAdjustCalcAmt = 0 AND R1619bIneligUnearnOrResources = FALSE AND xx R1619bIneligThreshold = FALSE, THEN RSpouse1619bElig = TRUE, ELSE FALSE	RSpouse1619bElig
    #note talked to DR should be spouseInelig1619 threshold RSpouse1619bIneligThreshold

  @RSpouse1619bElig  = WebCalc.new(:name => 'RSpouse1619bElig')
  @RSpouse1619bElig.operation = "
   SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
   SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
   R_SsiCoupleOverUnderAdjustCalcAmt = WebCalc.find_by_name('R_SsiCoupleOverUnderAdjustCalcAmt')
   R_SsiCoupleOverUnderAdjustCalcAmt = Float(R_SsiCoupleOverUnderAdjustCalcAmt.calculate manager)
   R1619bIneligUnearnOrResources = WebCalc.find_by_name('R1619bIneligUnearnOrResources')
   R1619bIneligUnearnOrResources = (R1619bIneligUnearnOrResources.calculate manager)
   RSpouse1619bIneligThreshold = WebCalc.find_by_name('RSpouse1619bIneligThreshold')
   RSpouse1619bIneligThreshold = (RSpouse1619bIneligThreshold.calculate manager)
   if ( SpouseSsiGet == 'Yes' && SpouseSsiOrCaidEarnAmt.to_f > 0 && (R_SsiCoupleOverUnderAdjustCalcAmt == 0) && R1619bIneligUnearnOrResources == false && RSpouse1619bIneligThreshold == false) then
     true
   else
    false
   end
  "
  @RSpouse1619bElig.save!
  end

  def self.down
  end
end
