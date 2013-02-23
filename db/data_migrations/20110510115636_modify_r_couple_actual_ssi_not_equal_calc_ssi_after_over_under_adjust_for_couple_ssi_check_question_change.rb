class ModifyRCoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjustForCoupleSsiCheckQuestionChange < ActiveRecord::Migration
  def self.up
    @R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust  = WebCalc.find_by_name('R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust')
   #old 
 #  SsiGet = manager.get_answer_by_question_name('SsiGet')
 #  SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
 #  SsiCoupleActualAmt = manager.get_answer_by_question_name('SsiCoupleActualAmt')
 #  R_SsiCoupleOverUnderAdjustCalcAmt = WebCalc.find_by_name('R_SsiCoupleOverUnderAdjustCalcAmt')
 #  R_SsiCoupleOverUnderAdjustCalcAmt = Float(R_SsiCoupleOverUnderAdjustCalcAmt.calculate manager)
 #  if (SsiGet == 'Yes' && SpouseSsiGet == 'Yes' && SsiCoupleActualAmt.to_f != R_SsiCoupleOverUnderAdjustCalcAmt) then
 #    true
 #  else
 #    false
 #  end
   
   
   
   #New
   #R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust = IF Current/What-If Button = Current AND SsiGet = Y AND SpouseSsiGet = Y AND (SsiUserActualAmt +  SsiSpouseActualAmt) <> R_SsiCoupleOverUnderAdjustCalcAmt, THEN TRUE, ELSE FALSE
   
    @R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust.update_attribute(:operation, "
    SsiGet = manager.get_answer_by_question_name('SsiGet')
    SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
    SsiSpouseActualAmt = manager.get_answer_by_question_name('SsiSpouseActualAmt')
    SsiUserActualAmt = manager.get_answer_by_question_name('SsiUserActualAmt')
    R_SsiCoupleOverUnderAdjustCalcAmt = WebCalc.find_by_name('R_SsiCoupleOverUnderAdjustCalcAmt')
    R_SsiCoupleOverUnderAdjustCalcAmt = Float(R_SsiCoupleOverUnderAdjustCalcAmt.calculate manager)
    if (SsiGet == 'Yes' && SpouseSsiGet == 'Yes' && (SsiUserActualAmt.to_f + SsiSpouseActualAmt.to_f) != R_SsiCoupleOverUnderAdjustCalcAmt) then
      true
    else
      false
    end
    
    ") unless @R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust.blank?
  end

  def self.down
  end
end
