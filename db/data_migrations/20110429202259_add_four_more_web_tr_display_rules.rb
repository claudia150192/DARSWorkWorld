class AddFourMoreWebTrDisplayRules < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'
    #TRPassHighIncomeNoSpousePASS
    #TRPassHighIncomeSpousePASS
    #TRSpousePASSHighIncomeNoUserPass
    #TRSpousePASSHighIncomeUserPASS
    @TrPassHighIncomeNoSpousePASS                                = WebTextResult.find_by_name('TRPassHighIncomeNoSpousePASS')
    @TrPassHighIncomeSpousePASS                                  = WebTextResult.find_by_name('TRPassHighIncomeSpousePASS')
    @TrSpousePASSHighIncomeNoUserPass                            = WebTextResult.find_by_name('TRSpousePASSHighIncomeNoUserPass')
    @TrSpousePASSHighIncomeUserPASS                              = WebTextResult.find_by_name('TRSpousePASSHighIncomeUserPASS')
    
    #If PassAmt > RIncAvailForPassMinusSpousePassAmt AND SpousePassAmt = 0
    @TrPassHighIncomeNoSpousePASS.update_attribute(:display_rules, "
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    RIncAvailForPassMinusSpousePassAmt = WebCalc.find_by_name('RIncAvailForPassMinusSpousePassAmt')
    RIncAvailForPassMinusSpousePassAmt = RIncAvailForPassMinusSpousePassAmt.calculate manager
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    ((PassAmt.to_f > RIncAvailForPassMinusSpousePassAmt) && (SpousePassAmt.to_f == 0))
    ") unless @TrPassHighIncomeNoSpousePASS.blank?
    
    #If PassAmt > RIncAvailForPassMinusSpousePassAmt AND SpousePassAmt > 0
    @TrPassHighIncomeSpousePASS.update_attribute(:display_rules, "
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    RIncAvailForPassMinusSpousePassAmt = WebCalc.find_by_name('RIncAvailForPassMinusSpousePassAmt')
    RIncAvailForPassMinusSpousePassAmt = RIncAvailForPassMinusSpousePassAmt.calculate manager
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    ((PassAmt.to_f > RIncAvailForPassMinusSpousePassAmt) && (SpousePassAmt.to_f > 0))
    ") unless @TrPassHighIncomeSpousePASS.blank?                     
      
    #TRSpousePASSHighIncomeNoUserPass If SpousePassAmt > RIncomeAvailforSpousePassMinusUserPassAmt AND PassAmt = 0
    @TrSpousePASSHighIncomeNoUserPass.update_attribute(:display_rules, "
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    RIncomeAvailforSpousePassMinusUserPassAmt = WebCalc.find_by_name('RIncomeAvailforSpousePassMinusUserPassAmt')
    RIncomeAvailforSpousePassMinusUserPassAmt = RIncomeAvailforSpousePassMinusUserPassAmt.calculate manager
    ((SpousePassAmt.to_f > RIncomeAvailforSpousePassMinusUserPassAmt) && (PassAmt.to_f == 0))
    ") unless @TrSpousePASSHighIncomeNoUserPass.blank?               
    
    #TRSpousePASSHighIncomeUserPASS If SpousePassAmt > RIncomeAvailforSpousePassMinusUserPassAmt AND PassAmt > 0
    @TrSpousePASSHighIncomeUserPASS.update_attribute(:display_rules, "
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    RIncomeAvailforSpousePassMinusUserPassAmt = WebCalc.find_by_name('RIncomeAvailforSpousePassMinusUserPassAmt')
    RIncomeAvailforSpousePassMinusUserPassAmt = RIncomeAvailforSpousePassMinusUserPassAmt.calculate manager
    ((SpousePassAmt.to_f > RIncomeAvailforSpousePassMinusUserPassAmt) && (PassAmt.to_f > 0))
    ") unless @TrSpousePASSHighIncomeUserPASS.blank?
  
  #this is all that are ready on 4.29.2011. Waiting on workbook 40 with revised medicaid calcs [different resource limits]
  end

  def self.down
  end
end
