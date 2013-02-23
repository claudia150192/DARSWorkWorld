class ModifySsiActualAmtForCoupleSsiNameChange < ActiveRecord::Migration
  def self.up
    
    #old rule
    #SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
  #  SsiCoupleActualAmt = manager.get_answer_by_question_name('SsiCoupleActualAmt')
  #  SsiUserActualAmt = manager.get_answer_by_question_name('SsiUserActualAmt')
  #  if SpouseSsiGet == 'Yes' then
  #    SsiCoupleActualAmt.to_f
  #  else 
  #    SsiUserActualAmt.to_f
  #  end
  
  #SsiUserActualAmt
  #SsiSpouseActualAmt
  #SpouseSsiGet
    
    #R_SsiActualAmt = IF SpouseSsiGet = Y, THEN SsiUserActualAmt + SsiSpouseActualAmt, ELSE SsiUserActualAmt
    
    @R_SsiActualAmt  = WebCalc.find_by_name('R_SsiActualAmt')
    @R_SsiActualAmt.update_attribute(:operation, "
    SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
    SsiSpouseActualAmt = manager.get_answer_by_question_name('SsiSpouseActualAmt')
    SsiUserActualAmt = manager.get_answer_by_question_name('SsiUserActualAmt')
    if SpouseSsiGet == 'Yes' then
      SsiUserActualAmt.to_f + SsiSpouseActualAmt.to_f
    else 
      SsiUserActualAmt.to_f
    end
    ") unless @R_SsiActualAmt.blank?
    
  end

  def self.down
  end
end
