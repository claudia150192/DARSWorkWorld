class AddOrderNumberToSomeTextResults < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'
    
    #Note this find_by_name is not working
    #@NSsdiEarnAmt  = WebCalc.find_by_name('nSsdiEarnAmt') from YC's example
    #This is not working
 #   @TrNoDisability                                              = WebTextResult.find_by_name('TRNoDisability')
 #   @TrAgeMoreThan64Yrs                                          = WebTextResult.find_by_name('TRAgeMoreThan64Yrs')
 #   @TrAgeLessThan15Yrs                                          = WebTextResult.find_by_name('TRAgeLessThan15Yrs')
 #   @TrSsiAmtDiscrepancy                                         = WebTextResult.find_by_name('TRSsiAmtDiscrepancy')
 #   @TrSsiCoupleAmtDiscrepancy                                   = WebTextResult.find_by_name('TRSsiCoupleAmtDiscrepancy')
 #   @TrDiAmtDiscrepancy                                          = WebTextResult.find_by_name('TRDiAmtDiscrepancy')
 #   @TrNoBpqy                                                    = WebTextResult.find_by_name('TRNoBpqy')
 #   @TrSsiFinalDetermination                                     = WebTextResult.find_by_name('TRSsiFinalDetermination')
 #   @TrDiFinalDetermination                                      = WebTextResult.find_by_name('TRDiFinalDetermination')
 #   @TrPassHighIncomeNoSpousePASS                                = WebTextResult.find_by_name('TRPassHighIncomeNoSpousePASS')
 #   @TrPassHighIncomeSpousePASS                                  = WebTextResult.find_by_name('TRPassHighIncomeSpousePASS')
 #   @TrSpousePASSHighIncomeNoUserPass                            = WebTextResult.find_by_name('TRSpousePASSHighIncomeNoUserPass')
 #   @TrSpousePASSHighIncomeUserPASS                              = WebTextResult.find_by_name('TRSpousePASSHighIncomeUserPASS')
 #   @TrSsiEligLostUnEarn                                         = WebTextResult.find_by_name('TRSsiEligLostUnEarn')
 #   @TrVaSsiCaidKeep                                             = WebTextResult.find_by_name('TRVaSsiCaidKeep')
 #   @TrVaSpouseSsiCaidKeep                                       = WebTextResult.find_by_name('TRVaSpouseSsiCaidKeep')
 #   @TrCaidLostThreshold                                         = WebTextResult.find_by_name('TRCaidLostThreshold')
 #   @TrCaidLostaIndividThresholdElig                             = WebTextResult.find_by_name('TRCaidLostaIndividThresholdElig')
 #   @TrApplyIndividThreshold                                     = WebTextResult.find_by_name('TRApplyIndividThreshold')
 #   @TrCaidLostIndividThreshold                                  = WebTextResult.find_by_name('TRCaidLostIndividThreshold')
 #   @TrSpouseCaidLostThreshold                                   = WebTextResult.find_by_name('TRSpouseCaidLostThreshold')
 #   @TrSpouseCaidLostIndividThresholdElig                        = WebTextResult.find_by_name('TRSpouseCaidLostIndividThresholdElig')
 #   @TrSpouseApplyIndividThreshold                               = WebTextResult.find_by_name('TRSpouseApplyIndividThreshold')
 #   @TrSpouseCaidLostIndividThreshold                            = WebTextResult.find_by_name('TRSpouseCaidLostIndividThreshold')
 #   @TrCaidLostCoupleSSIZeroNoEarn                               = WebTextResult.find_by_name('TRCaidLostCoupleSSIZeroNoEarn')
 #   @TrSpouseCaidLostCoupleSsiZeroNoEarn                         = WebTextResult.find_by_name('TRSpouseCaidLostCoupleSsiZeroNoEarn')
 #   @TrSeieLessThanMoEarnExcludeToMoLimit                        = WebTextResult.find_by_name('TRSeieLessThanMoEarnExcludeToMoLimit')
 #   @TrSieiLessThanMoLimitExcludeToMoLimit                       = WebTextResult.find_by_name('TRSieiLessThanMoLimitExcludeToMoLimit')
 #   @TrSieiZeroExcludeToMoLimit                                  = WebTextResult.find_by_name('TRSieiZeroExcludeToMoLimit')
 #   @TrCoupleSeieLessThanMoEarnExcludeToMoLimit                  = WebTextResult.find_by_name('TRCoupleSeieLessThanMoEarnExcludeToMoLimit')
 #   @TrCoupleSieiLessThanMoLimitExcludeToMoLimit                 = WebTextResult.find_by_name('TRCoupleSieiLessThanMoLimitExcludeToMoLimit')
 #   @TrCoupleSieiZeroExcludeToMoLimit                            = WebTextResult.find_by_name('TRCoupleSieiZeroExcludeToMoLimit')
 #   @TrTwpNo                                                     = WebTextResult.find_by_name('TRTwpNo')
 #   @TrTwpEnds                                                   = WebTextResult.find_by_name('TRTwpEnds')
  
   #@rate = FederalRate.find(:first, :conditions => ['start_date > ? AND end_date < ?',  Date.new(2011,01,01), Date.new(2012,01,01)])
  #@web_tip_webTipCSI1a                                               = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipCSI1a']) 
  # @QuestionGroup_User_Information                             = QuestionGroup.find(:first, :conditions => ['name = ?', 'User Information'])
  # the 2 examples were pulled from earlier migrations that worked.  The format seems the same.  The name filed exists in the db per Sequel Pro. The WebTextResult db name was pulled from the prior migration that created these entries
  #So i don't understand why line 89 "update_atribute"  is not working.  "@TrNoDisability  = " should create a var and it should not be nil. If the unless clause is added to the first update_attribute line the migration does nothing.  Removing the extra spaces in front of = still produces
  # Error message says: You have a nil object when you didn't expect it!
  #You might have expected an instance of ActiveRecord::Base.
  #The error occurred while evaluating nil.update_attribute
  @TrNoDisability                                              = WebTextResult.find_or_create_by_name('TRNoDisability')
  @TrAgeMoreThan64Yrs                                          = WebTextResult.find_or_create_by_name('TRAgeMoreThan64Yrs')
  @TrAgeLessThan15Yrs                                          = WebTextResult.find_or_create_by_name('TRAgeLessThan15Yrs')
  @TrSsiAmtDiscrepancy                                         = WebTextResult.find_or_create_by_name('TRSsiAmtDiscrepancy')
  @TrSsiCoupleAmtDiscrepancy                                   = WebTextResult.find_or_create_by_name('TRSsiCoupleAmtDiscrepancy')
  @TrDiAmtDiscrepancy                                          = WebTextResult.find_or_create_by_name('TRDiAmtDiscrepancy')
  @TrNoBpqy                                                    = WebTextResult.find_or_create_by_name('TRNoBpqy')
  @TrSsiFinalDetermination                                     = WebTextResult.find_or_create_by_name('TRSsiFinalDetermination')
  @TrDiFinalDetermination                                      = WebTextResult.find_or_create_by_name('TRDiFinalDetermination')
  @TrPassHighIncomeNoSpousePASS                                = WebTextResult.find_or_create_by_name('TRPassHighIncomeNoSpousePASS')
  @TrPassHighIncomeSpousePASS                                  = WebTextResult.find_or_create_by_name('TRPassHighIncomeSpousePASS')
  @TrSpousePASSHighIncomeNoUserPass                            = WebTextResult.find_or_create_by_name('TRSpousePASSHighIncomeNoUserPass')
  @TrSpousePASSHighIncomeUserPASS                              = WebTextResult.find_or_create_by_name('TRSpousePASSHighIncomeUserPASS')
  @TrSsiEligLostUnEarn                                         = WebTextResult.find_or_create_by_name('TRSsiEligLostUnEarn')
  @TrVaSsiCaidKeep                                             = WebTextResult.find_or_create_by_name('TRVaSsiCaidKeep')
  @TrVaSpouseSsiCaidKeep                                       = WebTextResult.find_or_create_by_name('TRVaSpouseSsiCaidKeep')
  @TrCaidLostThreshold                                         = WebTextResult.find_or_create_by_name('TRCaidLostThreshold')
  @TrCaidLostaIndividThresholdElig                             = WebTextResult.find_or_create_by_name('TRCaidLostaIndividThresholdElig')
  @TrApplyIndividThreshold                                     = WebTextResult.find_or_create_by_name('TRApplyIndividThreshold')
  @TrCaidLostIndividThreshold                                  = WebTextResult.find_or_create_by_name('TRCaidLostIndividThreshold')
  @TrSpouseCaidLostThreshold                                   = WebTextResult.find_or_create_by_name('TRSpouseCaidLostThreshold')
  @TrSpouseCaidLostIndividThresholdElig                        = WebTextResult.find_or_create_by_name('TRSpouseCaidLostIndividThresholdElig')
  @TrSpouseApplyIndividThreshold                               = WebTextResult.find_or_create_by_name('TRSpouseApplyIndividThreshold')
  @TrSpouseCaidLostIndividThreshold                            = WebTextResult.find_or_create_by_name('TRSpouseCaidLostIndividThreshold')
  @TrCaidLostCoupleSSIZeroNoEarn                               = WebTextResult.find_or_create_by_name('TRCaidLostCoupleSSIZeroNoEarn')
  @TrSpouseCaidLostCoupleSsiZeroNoEarn                         = WebTextResult.find_or_create_by_name('TRSpouseCaidLostCoupleSsiZeroNoEarn')
  @TrSeieLessThanMoEarnExcludeToMoLimit                        = WebTextResult.find_or_create_by_name('TRSeieLessThanMoEarnExcludeToMoLimit')
  @TrSieiLessThanMoLimitExcludeToMoLimit                       = WebTextResult.find_or_create_by_name('TRSieiLessThanMoLimitExcludeToMoLimit')
  @TrSieiZeroExcludeToMoLimit                                  = WebTextResult.find_or_create_by_name('TRSieiZeroExcludeToMoLimit')
  @TrCoupleSeieLessThanMoEarnExcludeToMoLimit                  = WebTextResult.find_or_create_by_name('TRCoupleSeieLessThanMoEarnExcludeToMoLimit')
  @TrCoupleSieiLessThanMoLimitExcludeToMoLimit                 = WebTextResult.find_or_create_by_name('TRCoupleSieiLessThanMoLimitExcludeToMoLimit')
  @TrCoupleSieiZeroExcludeToMoLimit                            = WebTextResult.find_or_create_by_name('TRCoupleSieiZeroExcludeToMoLimit')
  @TrTwpNo                                                     = WebTextResult.find_or_create_by_name('TRTwpNo')
  @TrTwpEnds                                                   = WebTextResult.find_or_create_by_name('TRTwpEnds')
  
  #  User.find(:first, :conditions => ["name = ?", name])
  
  
   @TrNoDisability.update_attribute(:order, '1') 
   @TrAgeMoreThan64Yrs.update_attribute(:order, '2') unless @TrAgeMoreThan64Yrs.blank?
   @TrAgeLessThan15Yrs.update_attribute(:order, '3') unless @TrAgeLessThan15Yrs.blank?
   @TrSsiAmtDiscrepancy.update_attribute(:order, '4') unless @TrSsiAmtDiscrepancy.blank?
   @TrSsiCoupleAmtDiscrepancy.update_attribute(:order, '5') unless @TrSsiCoupleAmtDiscrepancy.blank?
   @TrDiAmtDiscrepancy.update_attribute(:order, '6') unless @TrDiAmtDiscrepancy.blank?
   @TrNoBpqy.update_attribute(:order, '7') unless @TrNoBpqy.blank?
   @TrSsiFinalDetermination.update_attribute(:order, '8') unless @TrSsiFinalDetermination.blank?
   @TrDiFinalDetermination.update_attribute(:order, '9') unless @TrDiFinalDetermination.blank?
   @TrPassHighIncomeNoSpousePASS.update_attribute(:order, '10') unless @TrPassHighIncomeNoSpousePASS.blank?
   @TrPassHighIncomeSpousePASS.update_attribute(:order, '11') unless @TrPassHighIncomeSpousePASS.blank?
   @TrSpousePASSHighIncomeNoUserPass.update_attribute(:order, '12') unless @TrSpousePASSHighIncomeNoUserPass.blank?
   @TrSpousePASSHighIncomeUserPASS.update_attribute(:order, '13') unless @TrSpousePASSHighIncomeUserPASS.blank?
   @TrSsiEligLostUnEarn.update_attribute(:order, '14') unless @TrSsiEligLostUnEarn.blank?
   @TrVaSsiCaidKeep.update_attribute(:order, '15') unless @TrVaSsiCaidKeep.blank?
   @TrVaSpouseSsiCaidKeep.update_attribute(:order, '16') unless @TrVaSpouseSsiCaidKeep.blank?
   @TrCaidLostThreshold.update_attribute(:order, '17') unless @TrCaidLostThreshold.blank?
   @TrCaidLostaIndividThresholdElig.update_attribute(:order, '18') unless @TrCaidLostaIndividThresholdElig.blank?
   @TrApplyIndividThreshold.update_attribute(:order, '19') unless @TrApplyIndividThreshold.blank?
   @TrCaidLostIndividThreshold.update_attribute(:order, '20') unless @TrCaidLostIndividThreshold.blank?
   @TrSpouseCaidLostThreshold.update_attribute(:order, '21') unless @TrSpouseCaidLostThreshold.blank?
   @TrSpouseCaidLostIndividThresholdElig.update_attribute(:order, '22') unless @TrSpouseCaidLostIndividThresholdElig.blank?
   @TrSpouseApplyIndividThreshold.update_attribute(:order, '23') unless @TrSpouseApplyIndividThreshold.blank?
   @TrSpouseCaidLostIndividThreshold.update_attribute(:order, '24') unless @TrSpouseCaidLostIndividThreshold.blank?
   @TrCaidLostCoupleSSIZeroNoEarn.update_attribute(:order, '25') unless @TrCaidLostCoupleSSIZeroNoEarn.blank?
   @TrSpouseCaidLostCoupleSsiZeroNoEarn.update_attribute(:order, '26') unless @TrSpouseCaidLostCoupleSsiZeroNoEarn.blank?
   @TrSeieLessThanMoEarnExcludeToMoLimit.update_attribute(:order, '27') unless @TrSeieLessThanMoEarnExcludeToMoLimit.blank?
   @TrSieiLessThanMoLimitExcludeToMoLimit.update_attribute(:order, '28') unless @TrSieiLessThanMoLimitExcludeToMoLimit.blank?
   @TrSieiZeroExcludeToMoLimit.update_attribute(:order, '29') unless @TrSieiZeroExcludeToMoLimit.blank?
   @TrCoupleSeieLessThanMoEarnExcludeToMoLimit.update_attribute(:order, '30') unless @TrCoupleSeieLessThanMoEarnExcludeToMoLimit.blank?
   @TrCoupleSieiLessThanMoLimitExcludeToMoLimit.update_attribute(:order, '31') unless @TrCoupleSieiLessThanMoLimitExcludeToMoLimit.blank?
   @TrCoupleSieiZeroExcludeToMoLimit.update_attribute(:order, '32') unless @TrCoupleSieiZeroExcludeToMoLimit.blank?
   @TrTwpNo.update_attribute(:order, '33') unless @TrTwpNo.blank?
   @TrTwpEnds.update_attribute(:order, '34') unless @TrTwpEnds.blank?
   
  end

  def self.down
  end
end
