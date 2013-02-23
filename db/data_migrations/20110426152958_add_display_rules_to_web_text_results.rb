class AddDisplayRulesToWebTextResults < ActiveRecord::Migration
  def self.up
       require 'wwweb_session_manager'

    @TrNoDisability                                              = WebTextResult.find_by_name('TRNoDisability')
    @TrAgeMoreThan64Yrs                                          = WebTextResult.find_by_name('TRAgeMoreThan64Yrs')
    @TrAgeLessThan15Yrs                                          = WebTextResult.find_by_name('TRAgeLessThan15Yrs')
    @TrSsiAmtDiscrepancy                                         = WebTextResult.find_by_name('TRSsiAmtDiscrepancy')
    @TrSsiCoupleAmtDiscrepancy                                   = WebTextResult.find_by_name('TRSsiCoupleAmtDiscrepancy')
    @TrDiAmtDiscrepancy                                          = WebTextResult.find_by_name('TRDiAmtDiscrepancy')
    @TrNoBpqy                                                    = WebTextResult.find_by_name('TRNoBpqy')
    @TrSsiFinalDetermination                                     = WebTextResult.find_by_name('TRSsiFinalDetermination')
    @TrDiFinalDetermination                                      = WebTextResult.find_by_name('TRDiFinalDetermination')
  @TrPassHighIncomeNoSpousePASS                                = WebTextResult.find_by_name('TRPassHighIncomeNoSpousePASS')
  @TrPassHighIncomeSpousePASS                                  = WebTextResult.find_by_name('TRPassHighIncomeSpousePASS')
  @TrSpousePASSHighIncomeNoUserPass                            = WebTextResult.find_by_name('TRSpousePASSHighIncomeNoUserPass')
  @TrSpousePASSHighIncomeUserPASS                              = WebTextResult.find_by_name('TRSpousePASSHighIncomeUserPASS')
  @TrSsiEligLostUnEarn                                         = WebTextResult.find_by_name('TRSsiEligLostUnEarn')
  @TrVaSsiCaidKeep                                             = WebTextResult.find_by_name('TRVaSsiCaidKeep')
  @TrVaSpouseSsiCaidKeep                                       = WebTextResult.find_by_name('TRVaSpouseSsiCaidKeep')
  @TrCaidLostThreshold                                         = WebTextResult.find_by_name('TRCaidLostThreshold')
  @TrCaidLostaIndividThresholdElig                             = WebTextResult.find_by_name('TRCaidLostaIndividThresholdElig')
  @TrApplyIndividThreshold                                     = WebTextResult.find_by_name('TRApplyIndividThreshold')
  @TrCaidLostIndividThreshold                                  = WebTextResult.find_by_name('TRCaidLostIndividThreshold')
  @TrSpouseCaidLostThreshold                                   = WebTextResult.find_by_name('TRSpouseCaidLostThreshold')
  @TrSpouseCaidLostIndividThresholdElig                        = WebTextResult.find_by_name('TRSpouseCaidLostIndividThresholdElig')
  @TrSpouseApplyIndividThreshold                               = WebTextResult.find_by_name('TRSpouseApplyIndividThreshold')
  @TrSpouseCaidLostIndividThreshold                            = WebTextResult.find_by_name('TRSpouseCaidLostIndividThreshold')
  @TrCaidLostCoupleSSIZeroNoEarn                               = WebTextResult.find_by_name('TRCaidLostCoupleSSIZeroNoEarn')
  @TrSpouseCaidLostCoupleSsiZeroNoEarn                         = WebTextResult.find_by_name('TRSpouseCaidLostCoupleSsiZeroNoEarn')
  @TrSeieLessThanMoEarnExcludeToMoLimit                        = WebTextResult.find_by_name('TRSeieLessThanMoEarnExcludeToMoLimit')
  @TrSieiLessThanMoLimitExcludeToMoLimit                       = WebTextResult.find_by_name('TRSieiLessThanMoLimitExcludeToMoLimit')
  @TrSieiZeroExcludeToMoLimit                                  = WebTextResult.find_by_name('TRSieiZeroExcludeToMoLimit')
  @TrCoupleSeieLessThanMoEarnExcludeToMoLimit                  = WebTextResult.find_by_name('TRCoupleSeieLessThanMoEarnExcludeToMoLimit')
  @TrCoupleSieiLessThanMoLimitExcludeToMoLimit                 = WebTextResult.find_by_name('TRCoupleSieiLessThanMoLimitExcludeToMoLimit')
  @TrCoupleSieiZeroExcludeToMoLimit                            = WebTextResult.find_by_name('TRCoupleSieiZeroExcludeToMoLimit')
  @TrTwpNo                                                     = WebTextResult.find_by_name('TRTwpNo')
  @TrTwpEnds                                                   = WebTextResult.find_by_name('TRTwpEnds')

  
   @TrNoDisability.update_attribute(:display_rules, "
   Blind = manager.get_answer_by_question_name('Blind')
   Disability = manager.get_answer_by_question_name('Disability')
   Blind == 'No' && Disability == 'No'") unless @TrNoDisability.blank?                                 
   
   @TrAgeMoreThan64Yrs.update_attribute(:display_rules, "
   RAge = WebCalc.find_by_name('RAge')
   Age = RAge.calculate manager
   Age > 65") unless @TrAgeMoreThan64Yrs.blank?
   
   @TrAgeLessThan15Yrs.update_attribute(:display_rules, "
   RAge = WebCalc.find_by_name('RAge')
    Age = RAge.calculate manager
    Age < 15") unless @TrAgeLessThan15Yrs.blank?
    
  #  IF R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust = TRUE
   @TrSsiAmtDiscrepancy.update_attribute(:display_rules, "
   R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust = WebCalc.find_by_name('R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust')
     R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust = R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust.calculate manager
     R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust == true
   ") unless @TrSsiAmtDiscrepancy.blank?
                               
   #IF R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust = TRUE
      @TrSsiCoupleAmtDiscrepancy.update_attribute(:display_rules, "
       R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust = WebCalc.find_by_name('R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust')
        R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust = R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust.calculate manager
        R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust == true") unless @TrSsiCoupleAmtDiscrepancy.blank?                      
   
   
   #IF R_ActualSsdiPayNotEqualAllAdjust = TRUE
   @TrDiAmtDiscrepancy.update_attribute(:display_rules, "
    R_ActualSsdiPayNotEqualAllAdjust = WebCalc.find_by_name('R_ActualSsdiPayNotEqualAllAdjust')
     R_ActualSsdiPayNotEqualAllAdjust = R_ActualSsdiPayNotEqualAllAdjust.calculate manager
     R_ActualSsdiPayNotEqualAllAdjust == true") unless @TrDiAmtDiscrepancy.blank?                             
   
   #  If Current/What-If Button = Current AND BPQY = N AND (SsiGet = Y OR SsdiGet = Y)
      @TrNoBpqy.update_attribute(:display_rules, "
      BPQY = manager.get_answer_by_question_name('BPQY')
      SsiGet = manager.get_answer_by_question_name('SsiGet')
      SsdiGet = manager.get_answer_by_question_name('SsdiGet')
       BPQY == 'Yes' && (SsiGet == 'Yes' || SsdiGet == 'Yes'  )
       ") unless @TrNoBpqy.blank?                                       
   
   #    If SsiGetFinalDetermination = N
   @TrSsiFinalDetermination.update_attribute(:display_rules, "
   SsiGetFinalDetermination = manager.get_answer_by_question_name('SsiGetFinalDetermination')
   SsiGetFinalDetermination == 'No'") unless @TrSsiFinalDetermination.blank?
   
   #IF SsdiGet12MonthsSinceOnset = N
   @TrDiFinalDetermination.update_attribute(:display_rules, "
    SsdiGet = manager.get_answer_by_question_name('SsdiGet')
    SsdiGet12MonthsSinceOnset = manager.get_answer_by_question_name('SsdiGet12MonthsSinceOnset')
    SsdiGet == 'Yes' && SsdiGet12MonthsSinceOnset == 'No'") unless @TrDiFinalDetermination.blank?                         
  
# Ran into a challenge here. This TR refers to web calcs that have not been loaded.  Will need to come back and redothese after calcs have been addressed.   

  #@TrPassHighIncomeNoSpousePASS.update_attribute(:display_rules, "false") unless @TrPassHighIncomeNoSpousePASS.blank?

 #  # If PassAmt > RIncAvailForPassMinusSpousePassAmt AND SpousePassAmt = 0
 #  @TrPassHighIncomeNoSpousePASS.update_attribute(:display_rules, "
 #   PassAmt = manager.get_answer_by_question_name('PassAmt')
 #   SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
 #   RAge = WebCalc.find_by_name('RAge')
 #   Age = RAge.calculate manager 
 #  ") unless @TrPassHighIncomeNoSpousePASS.blank?                   
 #  
   #@TrPassHighIncomeSpousePASS.update_attribute(:display_rules, "false") unless @TrPassHighIncomeSpousePASS.blank?                     
   #@TrSpousePASSHighIncomeNoUserPass.update_attribute(:display_rules, "false") unless @TrSpousePASSHighIncomeNoUserPass.blank?               
   #@TrSpousePASSHighIncomeUserPASS.update_attribute(:display_rules, "false") unless @TrSpousePASSHighIncomeUserPASS.blank?                 
   #above have been done
   
   @TrSsiEligLostUnEarn.update_attribute(:display_rules, "false") unless @TrSsiEligLostUnEarn.blank?                            
   @TrVaSsiCaidKeep.update_attribute(:display_rules, "false") unless @TrVaSsiCaidKeep.blank?                                
   @TrVaSpouseSsiCaidKeep.update_attribute(:display_rules, "false") unless @TrVaSpouseSsiCaidKeep.blank?                          
   @TrCaidLostThreshold.update_attribute(:display_rules, "false") unless @TrCaidLostThreshold.blank?                            
   @TrCaidLostaIndividThresholdElig.update_attribute(:display_rules, "false") unless @TrCaidLostaIndividThresholdElig.blank?                
   @TrApplyIndividThreshold.update_attribute(:display_rules, "false") unless @TrApplyIndividThreshold.blank?                        
   @TrCaidLostIndividThreshold.update_attribute(:display_rules, "false") unless @TrCaidLostIndividThreshold.blank?                     
   @TrSpouseCaidLostThreshold.update_attribute(:display_rules, "false") unless @TrSpouseCaidLostThreshold.blank?                      
   @TrSpouseCaidLostIndividThresholdElig.update_attribute(:display_rules, "false") unless @TrSpouseCaidLostIndividThresholdElig.blank?           
   @TrSpouseApplyIndividThreshold.update_attribute(:display_rules, "false") unless @TrSpouseApplyIndividThreshold.blank?                  
   @TrSpouseCaidLostIndividThreshold.update_attribute(:display_rules, "false") unless @TrSpouseCaidLostIndividThreshold.blank?               
   @TrCaidLostCoupleSSIZeroNoEarn.update_attribute(:display_rules, "false") unless @TrCaidLostCoupleSSIZeroNoEarn.blank?                  
   @TrSpouseCaidLostCoupleSsiZeroNoEarn.update_attribute(:display_rules, "false") unless @TrSpouseCaidLostCoupleSsiZeroNoEarn.blank?            
   @TrSeieLessThanMoEarnExcludeToMoLimit.update_attribute(:display_rules, "false") unless @TrSeieLessThanMoEarnExcludeToMoLimit.blank?           
   @TrSieiLessThanMoLimitExcludeToMoLimit.update_attribute(:display_rules, "false") unless @TrSieiLessThanMoLimitExcludeToMoLimit.blank?          
   @TrSieiZeroExcludeToMoLimit.update_attribute(:display_rules, "false") unless @TrSieiZeroExcludeToMoLimit.blank?                     
   @TrCoupleSeieLessThanMoEarnExcludeToMoLimit.update_attribute(:display_rules, "false") unless @TrCoupleSeieLessThanMoEarnExcludeToMoLimit.blank?     
   @TrCoupleSieiLessThanMoLimitExcludeToMoLimit.update_attribute(:display_rules, "false") unless @TrCoupleSieiLessThanMoLimitExcludeToMoLimit.blank?    
   @TrCoupleSieiZeroExcludeToMoLimit.update_attribute(:display_rules, "false") unless @TrCoupleSieiZeroExcludeToMoLimit.blank?               
   @TrTwpNo.update_attribute(:display_rules, "false") unless @TrTwpNo.blank?                                        
   @TrTwpEnds.update_attribute(:display_rules, "false") unless @TrTwpEnds.blank?                                      
  
  
  
  
  end

  def self.down
  end
end
