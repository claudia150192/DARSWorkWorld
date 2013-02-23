class FirstPassAddingTextResults < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'
  
    @TRNoDisability                                          =WebTextResult.create!(:name => 'TRNoDisability',                                         :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRAgeMoreThan64Yrs                                      =WebTextResult.create!(:name => 'TRAgeMoreThan64Yrs',                                     :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRAgeLessThan15Yrs                                      =WebTextResult.create!(:name => 'TRAgeLessThan15Yrs',                                     :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSsiAmtDiscrepancy                                     =WebTextResult.create!(:name => 'TRSsiAmtDiscrepancy',                                    :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSsiCoupleAmtDiscrepancy                               =WebTextResult.create!(:name => 'TRSsiCoupleAmtDiscrepancy',                              :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRDiAmtDiscrepancy                                      =WebTextResult.create!(:name => 'TRDiAmtDiscrepancy',                                     :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRNoBpqy                                                =WebTextResult.create!(:name => 'TRNoBpqy',                                               :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSsiFinalDetermination                                 =WebTextResult.create!(:name => 'TRSsiFinalDetermination',                                :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRDiFinalDetermination                                  =WebTextResult.create!(:name => 'TRDiFinalDetermination',                                 :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRPassHighIncomeNoSpousePASS                            =WebTextResult.create!(:name => 'TRPassHighIncomeNoSpousePASS',                           :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRPassHighIncomeSpousePASS                              =WebTextResult.create!(:name => 'TRPassHighIncomeSpousePASS',                             :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSpousePASSHighIncomeNoUserPass                        =WebTextResult.create!(:name => 'TRSpousePASSHighIncomeNoUserPass',                       :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSpousePASSHighIncomeUserPASS                          =WebTextResult.create!(:name => 'TRSpousePASSHighIncomeUserPASS',                         :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSsiEligLostUnEarn                                     =WebTextResult.create!(:name => 'TRSsiEligLostUnEarn',                                    :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRVaSsiCaidKeep                                         =WebTextResult.create!(:name => 'TRVaSsiCaidKeep',                                        :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRVaSpouseSsiCaidKeep                                   =WebTextResult.create!(:name => 'TRVaSpouseSsiCaidKeep',                                  :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRCaidLostThreshold                                     =WebTextResult.create!(:name => 'TRCaidLostThreshold',                                    :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRCaidLostaIndividThresholdElig                         =WebTextResult.create!(:name => 'TRCaidLostaIndividThresholdElig',                        :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRApplyIndividThreshold                                 =WebTextResult.create!(:name => 'TRApplyIndividThreshold',                                :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRCaidLostIndividThreshold                              =WebTextResult.create!(:name => 'TRCaidLostIndividThreshold',                             :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSpouseCaidLostThreshold                               =WebTextResult.create!(:name => 'TRSpouseCaidLostThreshold',                              :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSpouseCaidLostIndividThresholdElig                    =WebTextResult.create!(:name => 'TRSpouseCaidLostIndividThresholdElig',                   :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSpouseApplyIndividThreshold                           =WebTextResult.create!(:name => 'TRSpouseApplyIndividThreshold',                          :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSpouseCaidLostIndividThreshold                        =WebTextResult.create!(:name => 'TRSpouseCaidLostIndividThreshold',                       :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRCaidLostCoupleSSIZeroNoEarn                           =WebTextResult.create!(:name => 'TRCaidLostCoupleSSIZeroNoEarn',                          :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSpouseCaidLostCoupleSsiZeroNoEarn                     =WebTextResult.create!(:name => 'TRSpouseCaidLostCoupleSsiZeroNoEarn',                    :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSeieLessThanMoEarnExcludeToMoLimit                    =WebTextResult.create!(:name => 'TRSeieLessThanMoEarnExcludeToMoLimit',                   :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSieiLessThanMoLimitExcludeToMoLimit                   =WebTextResult.create!(:name => 'TRSieiLessThanMoLimitExcludeToMoLimit',                  :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRSieiZeroExcludeToMoLimit                              =WebTextResult.create!(:name => 'TRSieiZeroExcludeToMoLimit',                             :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRCoupleSeieLessThanMoEarnExcludeToMoLimit              =WebTextResult.create!(:name => 'TRCoupleSeieLessThanMoEarnExcludeToMoLimit',             :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRCoupleSieiLessThanMoLimitExcludeToMoLimit             =WebTextResult.create!(:name => 'TRCoupleSieiLessThanMoLimitExcludeToMoLimit',            :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRCoupleSieiZeroExcludeToMoLimit                        =WebTextResult.create!(:name => 'TRCoupleSieiZeroExcludeToMoLimit',                       :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRTwpNo                                                 =WebTextResult.create!(:name => 'TRTwpNo',                                                :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TRTwpEnds                                               =WebTextResult.create!(:name => 'TRTwpEnds',                                              :display_rules => 'true',   :text => 'x',       :group_id => '1')
    @TREstimate                                              =WebTextResult.create!(:name => 'TREstimate',                                             :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSSIIncomePASSElig                                     =WebTextResult.create!(:name => 'TRSSIIncomePASSElig',                                    :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSSIEarnIrweElig                                       =WebTextResult.create!(:name => 'TRSSIEarnIrweElig',                                      :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSSIFinanceElig                                        =WebTextResult.create!(:name => 'TRSSIFinanceElig',                                       :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSSIWIElig                                             =WebTextResult.create!(:name => 'TRSSIWIElig',                                            :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSSIFinanceEligBlind                                   =WebTextResult.create!(:name => 'TRSSIFinanceEligBlind',                                  :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSSIWIEligBlind                                        =WebTextResult.create!(:name => 'TRSSIWIEligBlind',                                       :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSSIInKindAlt                                          =WebTextResult.create!(:name => 'TRSSIInKindAlt',                                         :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRPassNotUsed                                           =WebTextResult.create!(:name => 'TRPassNotUsed',                                          :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpousePassNotUsed                                     =WebTextResult.create!(:name => 'TRSpousePassNotUsed',                                    :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRPassNotUsedBlind                                      =WebTextResult.create!(:name => 'TRPassNotUsedBlind',                                     :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpousePassNotUsedBlind                                =WebTextResult.create!(:name => 'TRSpousePassNotUsedBlind',                               :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRPassPossYesPass                                       =WebTextResult.create!(:name => 'TRPassPossYesPass',                                      :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpousePassPossYesPass                                 =WebTextResult.create!(:name => 'TRSpousePassPossYesPass',                                :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRPassPossNoPass                                        =WebTextResult.create!(:name => 'TRPassPossNoPass',                                       :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRPassPossNoPassBlind                                   =WebTextResult.create!(:name => 'TRPassPossNoPassBlind',                                  :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpousePassPossNoPass                                  =WebTextResult.create!(:name => 'TRSpousePassPossNoPass',                                 :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpousePassPossNoPassBlind                             =WebTextResult.create!(:name => 'TRSpousePassPossNoPassBlind',                            :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRPassOther                                             =WebTextResult.create!(:name => 'TRPassOther',                                            :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRIrweNotUsed                                           =WebTextResult.create!(:name => 'TRIrweNotUsed',                                          :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRIrweNotUsedWithSEIELessThanEarn                       =WebTextResult.create!(:name => 'TRIrweNotUsedWithSEIELessThanEarn',                      :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpouseIrweNotUsed                                     =WebTextResult.create!(:name => 'TRSpouseIrweNotUsed',                                    :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpouseIrweNotUsedWithSEIELessThanEarn                 =WebTextResult.create!(:name => 'TRSpouseIrweNotUsedWithSEIELessThanEarn',                :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRBweNotUsed                                            =WebTextResult.create!(:name => 'TRBweNotUsed',                                           :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRBweNotUsedWithSEIELessThanEarn                        =WebTextResult.create!(:name => 'TRBweNotUsedWithSEIELessThanEarn',                       :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpouseBweNotUsed                                      =WebTextResult.create!(:name => 'TRSpouseBweNotUsed',                                     :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRSpouseBweNotUsedWithSEIELessThanEarn                  =WebTextResult.create!(:name => 'TRSpouseBweNotUsedWithSEIELessThanEarn',                 :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRDIIrweAvail                                           =WebTextResult.create!(:name => 'TRDIIrweAvail',                                          :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TRDISubAvail                                            =WebTextResult.create!(:name => 'TRDISubAvail',                                           :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TREarnRecSelf                                           =WebTextResult.create!(:name => 'TREarnRecSelf',                                          :display_rules => 'false',  :text => 'x',       :group_id => '1')
    @TREarnRecOther                                          =WebTextResult.create!(:name => 'TREarnRecOther',                                         :display_rules => 'false',  :text => 'x',       :group_id => '1')



    #@TrNoDisability                                              =WebTextResult.find_by_name('NoDisability')
    #@TrAgeMoreThan64Yrs                                          =WebTextResult.find_by_name('AgeMoreThan64Yrs')
    #@TrAgeLessThan15Yrs                                          =WebTextResult.find_by_name('AgeLessThan15Yrs')
    #@TrSsiAmtDiscrepancy                                         =WebTextResult.find_by_name('SsiAmtDiscrepancy')
    #@TrSsiCoupleAmtDiscrepancy                                   =WebTextResult.find_by_name('SsiCoupleAmtDiscrepancy')
    #@TrDiAmtDiscrepancy                                          =WebTextResult.find_by_name('DiAmtDiscrepancy')
    #@TrNoBpqy                                                    =WebTextResult.find_by_name('NoBpqy')
    #@TrSsiFinalDetermination                                     =WebTextResult.find_by_name('SsiFinalDetermination')
    #@TrDiFinalDetermination                                      =WebTextResult.find_by_name('DiFinalDetermination')
    #@TrPassHighIncomeNoSpousePASS                                =WebTextResult.find_by_name('PassHighIncomeNoSpousePASS')
    #@TrPassHighIncomeSpousePASS                                  =WebTextResult.find_by_name('PassHighIncomeSpousePASS')
    #@TrSpousePASSHighIncomeNoUserPass                            =WebTextResult.find_by_name('SpousePASSHighIncomeNoUserPass')
    #@TrSpousePASSHighIncomeUserPASS                              =WebTextResult.find_by_name('SpousePASSHighIncomeUserPASS')
    #@TrSsiEligLostUnEarn                                         =WebTextResult.find_by_name('SsiEligLostUnEarn')
    #@TrVaSsiCaidKeep                                             =WebTextResult.find_by_name('VaSsiCaidKeep')
    #@TrVaSpouseSsiCaidKeep                                       =WebTextResult.find_by_name('VaSpouseSsiCaidKeep')
    #@TrCaidLostThreshold                                         =WebTextResult.find_by_name('CaidLostThreshold')
    #@TrCaidLostaIndividThresholdElig                             =WebTextResult.find_by_name('CaidLostaIndividThresholdElig')
    #@TrApplyIndividThreshold                                     =WebTextResult.find_by_name('ApplyIndividThreshold')
    #@TrCaidLostIndividThreshold                                  =WebTextResult.find_by_name('CaidLostIndividThreshold')
    #@TrSpouseCaidLostThreshold                                   =WebTextResult.find_by_name('SpouseCaidLostThreshold')
    #@TrSpouseCaidLostIndividThresholdElig                        =WebTextResult.find_by_name('SpouseCaidLostIndividThresholdElig')
    #@TrSpouseApplyIndividThreshold                               =WebTextResult.find_by_name('SpouseApplyIndividThreshold')
    #@TrSpouseCaidLostIndividThreshold                            =WebTextResult.find_by_name('SpouseCaidLostIndividThreshold')
    #@TrCaidLostCoupleSSIZeroNoEarn                               =WebTextResult.find_by_name('CaidLostCoupleSSIZeroNoEarn')
    #@TrSpouseCaidLostCoupleSsiZeroNoEarn                         =WebTextResult.find_by_name('SpouseCaidLostCoupleSsiZeroNoEarn')
    #@TrSeieLessThanMoEarnExcludeToMoLimit                        =WebTextResult.find_by_name('SeieLessThanMoEarnExcludeToMoLimit')
    #@TrSieiLessThanMoLimitExcludeToMoLimit                       =WebTextResult.find_by_name('SieiLessThanMoLimitExcludeToMoLimit')
    #@TrSieiZeroExcludeToMoLimit                                  =WebTextResult.find_by_name('SieiZeroExcludeToMoLimit')
    #@TrCoupleSeieLessThanMoEarnExcludeToMoLimit                  =WebTextResult.find_by_name('CoupleSeieLessThanMoEarnExcludeToMoLimit')
    #@TrCoupleSieiLessThanMoLimitExcludeToMoLimit                 =WebTextResult.find_by_name('CoupleSieiLessThanMoLimitExcludeToMoLimit')
    #@TrCoupleSieiZeroExcludeToMoLimit                            =WebTextResult.find_by_name('CoupleSieiZeroExcludeToMoLimit')
    #@TrTwpNo                                                     =WebTextResult.find_by_name('TwpNo')
    #@TrTwpEnds                                                   =WebTextResult.find_by_name('TwpEnds')
    #@TrEstimate                                                  =WebTextResult.find_by_name('Estimate')
    #@TrSSIIncomePASSElig                                         =WebTextResult.find_by_name('SSIIncomePASSElig')
    #@TrSSIEarnIrweElig                                           =WebTextResult.find_by_name('SSIEarnIrweElig')
    #@TrSSIFinanceElig                                            =WebTextResult.find_by_name('SSIFinanceElig')
    #@TrSSIWIElig                                                 =WebTextResult.find_by_name('SSIWIElig')
    #@TrSSIFinanceEligBlind                                       =WebTextResult.find_by_name('SSIFinanceEligBlind')
    #@TrSSIWIEligBlind                                            =WebTextResult.find_by_name('SSIWIEligBlind')
    #@TrSSIInKindAlt                                              =WebTextResult.find_by_name('SSIInKindAlt')
    #@TrPassNotUsed                                               =WebTextResult.find_by_name('PassNotUsed')
    #@TrSpousePassNotUsed                                         =WebTextResult.find_by_name('SpousePassNotUsed')
    #@TrPassNotUsedBlind                                          =WebTextResult.find_by_name('PassNotUsedBlind')
    #@TrSpousePassNotUsedBlind                                    =WebTextResult.find_by_name('SpousePassNotUsedBlind')
    #@TrPassPossYesPass                                           =WebTextResult.find_by_name('PassPossYesPass')
    #@TrSpousePassPossYesPass                                     =WebTextResult.find_by_name('SpousePassPossYesPass')
    #@TrPassPossNoPass                                            =WebTextResult.find_by_name('PassPossNoPass')
    #@TrPassPossNoPassBlind                                       =WebTextResult.find_by_name('PassPossNoPassBlind')
    #@TrSpousePassPossNoPass                                      =WebTextResult.find_by_name('SpousePassPossNoPass')
    #@TrSpousePassPossNoPassBlind                                 =WebTextResult.find_by_name('SpousePassPossNoPassBlind')
    #@TrPassOther                                                 =WebTextResult.find_by_name('PassOther')
    #@TrIrweNotUsed                                               =WebTextResult.find_by_name('IrweNotUsed')
    #@TrIrweNotUsedWithSEIELessThanEarn                           =WebTextResult.find_by_name('IrweNotUsedWithSEIELessThanEarn')
    #@TrSpouseIrweNotUsed                                         =WebTextResult.find_by_name('SpouseIrweNotUsed')
    #@TrSpouseIrweNotUsedWithSEIELessThanEarn                     =WebTextResult.find_by_name('SpouseIrweNotUsedWithSEIELessThanEarn')
    #@TrBweNotUsed                                                =WebTextResult.find_by_name('BweNotUsed')
    #@TrBweNotUsedWithSEIELessThanEarn                            =WebTextResult.find_by_name('BweNotUsedWithSEIELessThanEarn')
    #@TrSpouseBweNotUsed                                          =WebTextResult.find_by_name('SpouseBweNotUsed')
    #@TrSpouseBweNotUsedWithSEIELessThanEarn                      =WebTextResult.find_by_name('SpouseBweNotUsedWithSEIELessThanEarn')
    #@TrDIIrweAvail                                               =WebTextResult.find_by_name('DIIrweAvail')
    #@TrDISubAvail                                                =WebTextResult.find_by_name('DISubAvail')
    #@TrEarnRecSelf                                               =WebTextResult.find_by_name('EarnRecSelf')
    #@TrEarnRecOther                                              =WebTextResult.find_by_name('EarnRecOther')

    @TRNoDisability.update_attribute(:text, 'Alert - No Disability:  You are not considered blind or disabled.  This version of WW-Web will not provide the correct results for your situation.') unless @TRNoDisability.blank?
    @TRAgeMoreThan64Yrs.update_attribute(:text, 'Alert - You are 65 years old or older.  This version of WW-Web will not provide correct results for those over 65 years old.') unless @TRAgeMoreThan64Yrs.blank?
    @TRAgeLessThan15Yrs.update_attribute(:text, 'Alert - You are less than 15 years old.  This version of WW-Web will not provide correct results for those under 15 years old. If you choose a future Situation Date when you are at least 15 years old, WW-Web will calculate results based on current benefit levels.') unless @TRAgeLessThan15Yrs.blank?
    @TRSsiAmtDiscrepancy.update_attribute(:text, 'Alert - SSI Check Amount Error:  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.') unless @TRSsiAmtDiscrepancy.blank?
    @TRSsiCoupleAmtDiscrepancy.update_attribute(:text, 'Alert - Couple SSI Check Amount Error:   DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.') unless @TRSsiCoupleAmtDiscrepancy.blank?
    @TRDiAmtDiscrepancy.update_attribute(:text, 'Alert - SSDI (Title II) Check Amount Error:  DO NOT PROCEED UNTIL YOU HAVE FOUND THE REASON FOR THIS DISCREPANCY AND CORRECTED IT.') unless @TRDiAmtDiscrepancy.blank?
    @TRNoBpqy.update_attribute(:text, "Alert - No BPQY Report:  You indicated that you receive SSI and/or SSDI benefits, but you do not have a current Benefits Planning Query (BPQY) report from SSA.  You should request this report in order to verify your benefit amounts, SSA's records, and your benefit policy status.") unless @TRNoBpqy.blank?
    @TRSsiFinalDetermination.update_attribute(:text, 'Alert - Earning SGA could jeopardize your SSI Eligibility:  Because you have not been notified by SSA that a final determination of your eligibility has been made, or it has been less than 12 months since the onset of your disability, you should check with your SSA Claims Representative about the consequences of engaging in Substantial Gainful Activity (SGA) before you attempt to earn more than the SGA amount.') unless @TRSsiFinalDetermination.blank?
    @TRDiFinalDetermination.update_attribute(:text, 'Alert - Earning SGA could jeopardize your SSDI Eligibility:  Because at least 12 months has not passed since the onset of your disability, you should check with your SSA Claims Representative about the consequences of engaging in Substantial Gainful Activity (SGA) before you attempt to  earn more than the SGA amount.') unless @TRDiFinalDetermination.blank?
    @TRPassHighIncomeNoSpousePASS.update_attribute(:text, 'Alert - PASS Higher than Available Income:  Your PASS can not be greater than the amount of income (excluding SSI cash benefits--but including deemed income and in-kind support under the PMV rule) that you have available to set aside for employability investments and work expenses. YOU MUST REDUCE YOUR PASS OR WORKWORLD WILL NOT CALCULATE CORRECT RESULTS!') unless @TRPassHighIncomeNoSpousePASS.blank?
    @TRPassHighIncomeSpousePASS.update_attribute(:text, "Alert - PASSes (Yours and Spouse's) Higher than Available Income:  Your PASS can not be greater than the amount of income (excluding SSI cash benefits--but including deemed income and in-kind support under the PMV rule) that you have available to set aside for employability investments and work expenses. Income your spouse is setting aside in a PASS is not available. YOU OR YOUR SPOUSE'S PASS MUST BE REDUCED OR WORKWORLD WILL NOT CALCULATE CORRECT RESULTS!") unless @TRPassHighIncomeSpousePASS.blank?
    @TRSpousePASSHighIncomeNoUserPass.update_attribute(:text, "Alert - Spouse's PASS Higher than Available Income:  Your Spouse's PASS can not be greater than the amount of income (excluding SSI cash benefits--but including any in-kind support under the PMV rule) that your spouse has available to set aside for employability investments and work expenses. YOUR SPOUSE'S PASS MUST BE REDUCED OR WORKWORLD WILL NOT CALCULATE CORRECT RESULTS!") unless @TRSpousePASSHighIncomeNoUserPass.blank?
    @TRSpousePASSHighIncomeUserPASS.update_attribute(:text, "Alert - PASSes (Spouse's and Yours) Higher than Available Income:  Your Spouse's PASS can not be greater than the amount of income (excluding SSI cash benefits--but including in-kind support under the PMV rule) that you have available to set aside for employability investments and work expenses. Income you are setting aside in a PASS is not available. YOU OR YOUR SPOUSE'S PASS MUST BE REDUCED OR WORKWORLD WILL NOT CALCULATE CORRECT RESULTS!") unless @TRSpousePASSHighIncomeUserPASS.blank?
    @TRSsiEligLostUnEarn.update_attribute(:text, 'Alert - SSI Eligibility lost because of Unearned Income:  Your countable unearned income is too high for you to stay eligible for SSI benefits.  You could stay eligible if you set aside money and include it in a PASS (in addition to any income already included in a PASS).  [NOTE:  Your Medicaid benefits stop unless your State has special provisions.  If Medicaid stops and you have SSDI and Medicare Part B coverage, go back and answer YES to the question, Is Medicare Part B Premium deducted from your SSDI Check?]') unless @TRSsiEligLostUnEarn.blank?
    @TRVaSsiCaidKeep.update_attribute(:text, 'Alert - Keeping Medicaid in Virginia:  Your SSI cash benefit is zero because of countable income that includes earnings. If you need Medicaid coverage you must inform the Virginia Department of Social Services that you need Medicaid to work.') unless @TRVaSsiCaidKeep.blank?
    @TRVaSpouseSsiCaidKeep.update_attribute(:text, "Alert - Spouse Keeping Medicaid in Virginia:  Your spouse's SSI cash benefit is zero because of countable income that includes earnings. If your spouse needs Medicaid coverage the Virginia Department of Social Services must be informed that your spouse needs Medicaid to work.") unless @TRVaSpouseSsiCaidKeep.blank?
    @TRCaidLostThreshold.update_attribute(:text, "Alert - Medicaid Lost (State Threshold):  Your monthly gross earned income is greater than the monthly Threshold amount for your State.  Unless you can establish an Individualized Threshold, or unless your State has other special Medicaid provisions, you will lose your Medicaid coverage.  [NOTE:If Medicaid stops and you have SSDI and Medicare Part B coverage, go back and answer YES to the question, Is Medicare Part B Premium deducted from your SSDI Check?]") unless @TRCaidLostThreshold.blank?
    @TRCaidLostaIndividThresholdElig.update_attribute(:text, 'Recommendation - You may be able to establish an Individualized Threshold:  Since you have sufficient employability investments and/or work expenses, you may be able to include them in a PASS, and/or in an IRWE or BWE and establish an Individualized Threshold that would allow you to keep Medicaid benefits.') unless @TRCaidLostaIndividThresholdElig.blank?
    @TRApplyIndividThreshold.update_attribute(:text, 'Recommendation - Apply for Individualized Threshold: Your monthly gross earned income is greater than the Threshold amount for your State which means that you could lose your Medicaid coverage. However, you should apply for an Individualized Threshold because you have an IRWE, BWE and/or PASS large enough to allow you to keep your Medicaid coverage.') unless @TRApplyIndividThreshold.blank?
    @TRCaidLostIndividThreshold.update_attribute(:text, 'Alert - Medicaid Lost (Individualized Threshold):  Your annualized gross earned income is greater than your Individualized Threshold amount.  Unless your State has other special Medicaid provisions, you will lose your Medicaid coverage.  [NOTE:If Medicaid stops and you have SSDI and Medicare Part B coverage, go back and answer YES to the question, Is Your Medicare Part B Premium deducted from your SSDI Payment?]') unless @TRCaidLostIndividThreshold.blank?
    @TRSpouseCaidLostThreshold.update_attribute(:text, "Alert - Spouse Medicaid Lost (State Threshold):  Your spouse's monthly gross earned income is greater than the monthly Threshold amount for your State.  Unless your spouse can establish an Individualized Threshold, or unless your State has other special Medicaid provisions, your spouse will lose Medicaid coverage.") unless @TRSpouseCaidLostThreshold.blank?
    @TRSpouseCaidLostIndividThresholdElig.update_attribute(:text, 'Recommendation - Your spouse may be able to establish an individualized threshold:  Since your spouse has sufficient employability investments and/or/work expenses, you may be able to include them in a PASS, or in an IRWE or BWE, and establish an individualized threshold that would allow your spouse to keep Medicaid benefits.') unless @TRSpouseCaidLostIndividThresholdElig.blank?
    @TRSpouseApplyIndividThreshold.update_attribute(:text, "Recommendation - Spouse Apply for Individualized Threshold: Your spouse's monthly gross earned income is greater than the monthly Threshold amount for your State, which means that your spouse could lose Medicaid coverage. However, your spouse should apply for an Individualized Threshold because your spouse has an IRWE, BWE and/or PASS large enough to keep Medicaid coverage.") unless @TRSpouseApplyIndividThreshold.blank?
    @TRSpouseCaidLostIndividThreshold.update_attribute(:text, "Alert - Spouse Medicaid Lost (Individualized Threshold):  Your spouse's annualized gross earned income is greater than your spouse's Individualized Threshold amount.  Unless your State has other special Medicaid provisions, your spouse will lose Medicaid coverage.") unless @TRSpouseCaidLostIndividThreshold.blank?
    @TRCaidLostCoupleSSIZeroNoEarn.update_attribute(:text, "Alert - Medicaid Lost (Spouse Earnings):  Your combined income has caused your SSI cash benefit to be zero.  Because your spouse has earnings, your spouse qualifies for Medicaid under 1619b (unless your spouse's earnings exceed the Threshold).  Because you have no earnings you will lose your Medicaid eligibility, though you may be eligible under another State program.  If you were to earn $1 or more per month, you would qualify for Medicaid under 1619b.") unless @TRCaidLostCoupleSSIZeroNoEarn.blank?
    @TRSpouseCaidLostCoupleSsiZeroNoEarn.update_attribute(:text, 'Alert - Spouse Medicaid Lost:  Your combined income has caused your SSI cash benefit to be zero.  Because you have earnings, you qualify for Medicaid under 1619b (unless your earnings exceed the threshold).  Because your spouse has no earnings your spouse will lose Medicaid eligibility, though your spouse may be eligible under another State program.  If your spouse were to earn $1 or more per month, your spouse would qualify for Medicaid under 1619b.') unless @TRSpouseCaidLostCoupleSsiZeroNoEarn.blank?
    @TRSeieLessThanMoEarnExcludeToMoLimit.update_attribute(:text, 'Alert - Your Student Earned Income Exclusion (SEIE) is less than your monthly earnings. But you say you have not reached your annual SEIE limit. You must exclude earnings up to the monthly SEIE limit until your annual limit is reached.') unless @TRSeieLessThanMoEarnExcludeToMoLimit.blank?
    @TRSieiLessThanMoLimitExcludeToMoLimit.update_attribute(:text, 'Alert - Your Student Earned Income Exclusion (SEIE) is less than the SEIE monthly limit. But you say you have not reached your annual SEIE limit. You must exclude earnings up to the monthly SEIE limit until your annual limit is reached.') unless @TRSieiLessThanMoLimitExcludeToMoLimit.blank?
    @TRSieiZeroExcludeToMoLimit.update_attribute(:text, 'Alert - You have excluded none of your earned income as a Student Earned Income Exclusion (SEIE). But you say you have not reached your annual SEIE limit. You must exclude earnings up to the monthly SEIE limit until your annual limit is reached.') unless @TRSieiZeroExcludeToMoLimit.blank?
    @TRCoupleSeieLessThanMoEarnExcludeToMoLimit.update_attribute(:text, "Alert - Your Student Earned Income Exclusion (SEIE) plus your spouse's SEIE is less than the sum of your monthly earnings and your spouse's. But you say you have not reached your annual SEIE limit. You and/or your spouse must exclude earnings up to the monthly SEIE limit until your annual limit is reached.") unless @TRCoupleSeieLessThanMoEarnExcludeToMoLimit.blank?
    @TRCoupleSieiLessThanMoLimitExcludeToMoLimit.update_attribute(:text, "Alert - Your Student Earned Income Exclusion (SEIE) plus your spouse's SEIE is less than the SEIE monthly limit. But you say you have not reached your annual SEIE limit. You and/or your spouse must exclude earnings up to the monthly SEIE limit until your annual limit is reached.") unless @TRCoupleSieiLessThanMoLimitExcludeToMoLimit.blank?
    @TRCoupleSieiZeroExcludeToMoLimit.update_attribute(:text, 'Alert - You and your spouse have exluded none of your earned income as a Student Earned Income Exclusion (SEIE). But you say you have not reached your annual SEIE limit. You and/or your spouse must exclude earnings up to the monthly SEIE limit until your annual limit is reached.') unless @TRCoupleSieiZeroExcludeToMoLimit.blank?
    @TRTwpNo.update_attribute(:text, 'Alert - Your SSDI (Title II) Check Stops:  Your countable monthly earnings of cause your SSDI check to stop because they exceed the Substantial Gainful Activity (SGA) amount, and you have completed your Trial Work Period (TWP) and Grace Period.  An IRWE or Subsidy (in addition to any IRWE or subsidy you may already have), or drop in earnings could allow you to continue getting your cash benefit until you complete your Extended Period of Eligibility (EPE).') unless @TRTwpNo.blank?
    @TRTwpEnds.update_attribute(:text, 'Alert - Working after your TWP:  Because your countable monthly earnings are greater than the Substantial Gainful Activity (SGA) amount,  your SSDI (Title II) cash benefit will stop when your Trial Work Period (TWP) and Grace Period end unless you have an IRWE or Subsidy of at least (in addition to any IRWE or subsidy you already have), or your earnings drop by that amount.  In such circumstances you would receive your full cash benefit as long as you are in your Extended Period of Eligibility (EPE).') unless @TRTwpEnds.blank?
    @TREstimate                                            .update_attribute(:text, 'x') unless @TREstimate.blank?
    @TRSSIIncomePASSElig                                   .update_attribute(:text, 'x') unless @TRSSIIncomePASSElig.blank?
    @TRSSIEarnIrweElig                                     .update_attribute(:text, 'x') unless @TRSSIEarnIrweElig.blank?
    @TRSSIFinanceElig                                      .update_attribute(:text, 'x') unless @TRSSIFinanceElig.blank?
    @TRSSIWIElig                                           .update_attribute(:text, 'x') unless @TRSSIWIElig.blank?
    @TRSSIFinanceEligBlind                                 .update_attribute(:text, 'x') unless @TRSSIFinanceEligBlind.blank?
    @TRSSIWIEligBlind                                      .update_attribute(:text, 'x') unless @TRSSIWIEligBlind.blank?
    @TRSSIInKindAlt                                        .update_attribute(:text, 'x') unless @TRSSIInKindAlt.blank?
    @TRPassNotUsed                                         .update_attribute(:text, 'x') unless @TRPassNotUsed.blank?
    @TRSpousePassNotUsed                                   .update_attribute(:text, 'x') unless @TRSpousePassNotUsed.blank?
    @TRPassNotUsedBlind                                    .update_attribute(:text, 'x') unless @TRPassNotUsedBlind.blank?
    @TRSpousePassNotUsedBlind                              .update_attribute(:text, 'x') unless @TRSpousePassNotUsedBlind.blank?
    @TRPassPossYesPass                                     .update_attribute(:text, 'x') unless @TRPassPossYesPass.blank?
    @TRSpousePassPossYesPass                               .update_attribute(:text, 'x') unless @TRSpousePassPossYesPass.blank?
    @TRPassPossNoPass                                      .update_attribute(:text, 'x') unless @TRPassPossNoPass.blank?
    @TRPassPossNoPassBlind                                 .update_attribute(:text, 'x') unless @TRPassPossNoPassBlind.blank?
    @TRSpousePassPossNoPass                                .update_attribute(:text, 'x') unless @TRSpousePassPossNoPass.blank?
    @TRSpousePassPossNoPassBlind                           .update_attribute(:text, 'x') unless @TRSpousePassPossNoPassBlind.blank?
    @TRPassOther                                           .update_attribute(:text, 'x') unless @TRPassOther.blank?
    @TRIrweNotUsed                                         .update_attribute(:text, 'x') unless @TRIrweNotUsed.blank?
    @TRIrweNotUsedWithSEIELessThanEarn                     .update_attribute(:text, 'x') unless @TRIrweNotUsedWithSEIELessThanEarn.blank?
    @TRSpouseIrweNotUsed                                   .update_attribute(:text, 'x') unless @TRSpouseIrweNotUsed.blank?
    @TRSpouseIrweNotUsedWithSEIELessThanEarn               .update_attribute(:text, 'x') unless @TRSpouseIrweNotUsedWithSEIELessThanEarn.blank?
    @TRBweNotUsed                                          .update_attribute(:text, 'x') unless @TRBweNotUsed.blank?
    @TRBweNotUsedWithSEIELessThanEarn                      .update_attribute(:text, 'x') unless @TRBweNotUsedWithSEIELessThanEarn.blank?
    @TRSpouseBweNotUsed                                    .update_attribute(:text, 'x') unless @TRSpouseBweNotUsed.blank?
    @TRSpouseBweNotUsedWithSEIELessThanEarn                .update_attribute(:text, 'x') unless @TRSpouseBweNotUsedWithSEIELessThanEarn.blank?
    @TRDIIrweAvail                                         .update_attribute(:text, 'x') unless @TRDIIrweAvail.blank?
    @TRDISubAvail                                          .update_attribute(:text, 'x') unless @TRDISubAvail.blank?
    @TREarnRecSelf                                         .update_attribute(:text, 'x') unless @TREarnRecSelf.blank?
    @TREarnRecOther                                        .update_attribute(:text, 'x') unless @TREarnRecOther.blank?


    #@TRNoDisability.update_attribute(:text, '') unless @TRNoDisability.blank?
    #@TRAgeMoreThan64Yrs                                    .update_attribute(:text, '') unless @TRAgeMoreThan64Yrs.blank?
    #@TRAgeLessThan15Yrs                                    .update_attribute(:text, '') unless @TRAgeLessThan15Yrs.blank?
    #@TRSsiAmtDiscrepancy                                   .update_attribute(:text, '') unless @TRSsiAmtDiscrepancy.blank?
    #@TRSsiCoupleAmtDiscrepancy                             .update_attribute(:text, '') unless @TRSsiCoupleAmtDiscrepancy.blank?
    #@TRDiAmtDiscrepancy                                    .update_attribute(:text, '') unless @TRDiAmtDiscrepancy.blank?
    #@TRNoBpqy                                              .update_attribute(:text, '') unless @TRNoBpqy.blank?
    #@TRSsiFinalDetermination                               .update_attribute(:text, '') unless @TRSsiFinalDetermination.blank?
    #@TRDiFinalDetermination                                .update_attribute(:text, '') unless @TRDiFinalDetermination.blank?
    #@TRPassHighIncomeNoSpousePASS                          .update_attribute(:text, '') unless @TRPassHighIncomeNoSpousePASS.blank?
    #@TRPassHighIncomeSpousePASS                            .update_attribute(:text, '') unless @TRPassHighIncomeSpousePASS.blank?
    #@TRSpousePASSHighIncomeNoUserPass                      .update_attribute(:text, '') unless @TRSpousePASSHighIncomeNoUserPass.blank?
    #@TRSpousePASSHighIncomeUserPASS                        .update_attribute(:text, '') unless @TRSpousePASSHighIncomeUserPASS.blank?
    #@TRSsiEligLostUnEarn                                   .update_attribute(:text, '') unless @TRSsiEligLostUnEarn.blank?
    #@TRVaSsiCaidKeep                                       .update_attribute(:text, '') unless @TRVaSsiCaidKeep.blank?
    #@TRVaSpouseSsiCaidKeep                                 .update_attribute(:text, '') unless @TRVaSpouseSsiCaidKeep.blank?
    #@TRCaidLostThreshold                                   .update_attribute(:text, '') unless @TRCaidLostThreshold.blank?
    #@TRCaidLostaIndividThresholdElig                       .update_attribute(:text, '') unless @TRCaidLostaIndividThresholdElig.blank?
    #@TRApplyIndividThreshold                               .update_attribute(:text, '') unless @TRApplyIndividThreshold.blank?
    #@TRCaidLostIndividThreshold                            .update_attribute(:text, '') unless @TRCaidLostIndividThreshold.blank?
    #@TRSpouseCaidLostThreshold                             .update_attribute(:text, '') unless @TRSpouseCaidLostThreshold.blank?
    #@TRSpouseCaidLostIndividThresholdElig                  .update_attribute(:text, '') unless @TRSpouseCaidLostIndividThresholdElig.blank?
    #@TRSpouseApplyIndividThreshold                         .update_attribute(:text, '') unless @TRSpouseApplyIndividThreshold.blank?
    #@TRSpouseCaidLostIndividThreshold                      .update_attribute(:text, '') unless @TRSpouseCaidLostIndividThreshold.blank?
    #@TRCaidLostCoupleSSIZeroNoEarn                         .update_attribute(:text, '') unless @TRCaidLostCoupleSSIZeroNoEarn.blank?
    #@TRSpouseCaidLostCoupleSsiZeroNoEarn                   .update_attribute(:text, '') unless @TRSpouseCaidLostCoupleSsiZeroNoEarn.blank?
    #@TRSeieLessThanMoEarnExcludeToMoLimit                  .update_attribute(:text, '') unless @TRSeieLessThanMoEarnExcludeToMoLimit.blank?
    #@TRSieiLessThanMoLimitExcludeToMoLimit                 .update_attribute(:text, '') unless @TRSieiLessThanMoLimitExcludeToMoLimit.blank?
    #@TRSieiZeroExcludeToMoLimit                            .update_attribute(:text, '') unless @TRSieiZeroExcludeToMoLimit.blank?
    #@TRCoupleSeieLessThanMoEarnExcludeToMoLimit            .update_attribute(:text, '') unless @TRCoupleSeieLessThanMoEarnExcludeToMoLimit.blank?
    #@TRCoupleSieiLessThanMoLimitExcludeToMoLimit           .update_attribute(:text, '') unless @TRCoupleSieiLessThanMoLimitExcludeToMoLimit.blank?
    #@TRCoupleSieiZeroExcludeToMoLimit                      .update_attribute(:text, '') unless @TRCoupleSieiZeroExcludeToMoLimit.blank?
    #@TRTwpNo                                               .update_attribute(:text, '') unless @TRTwpNo.blank?
    #@TRTwpEnds                                             .update_attribute(:text, '') unless @TRTwpEnds.blank?
    #@TREstimate                                            .update_attribute(:text, '') unless @TREstimate.blank?
    #@TRSSIIncomePASSElig                                   .update_attribute(:text, '') unless @TRSSIIncomePASSElig.blank?
    #@TRSSIEarnIrweElig                                     .update_attribute(:text, '') unless @TRSSIEarnIrweElig.blank?
    #@TRSSIFinanceElig                                      .update_attribute(:text, '') unless @TRSSIFinanceElig.blank?
    #@TRSSIWIElig                                           .update_attribute(:text, '') unless @TRSSIWIElig.blank?
    #@TRSSIFinanceEligBlind                                 .update_attribute(:text, '') unless @TRSSIFinanceEligBlind.blank?
    #@TRSSIWIEligBlind                                      .update_attribute(:text, '') unless @TRSSIWIEligBlind.blank?
    #@TRSSIInKindAlt                                        .update_attribute(:text, '') unless @TRSSIInKindAlt.blank?
    #@TRPassNotUsed                                         .update_attribute(:text, '') unless @TRPassNotUsed.blank?
    #@TRSpousePassNotUsed                                   .update_attribute(:text, '') unless @TRSpousePassNotUsed.blank?
    #@TRPassNotUsedBlind                                    .update_attribute(:text, '') unless @TRPassNotUsedBlind.blank?
    #@TRSpousePassNotUsedBlind                              .update_attribute(:text, '') unless @TRSpousePassNotUsedBlind.blank?
    #@TRPassPossYesPass                                     .update_attribute(:text, '') unless @TRPassPossYesPass.blank?
    #@TRSpousePassPossYesPass                               .update_attribute(:text, '') unless @TRSpousePassPossYesPass.blank?
    #@TRPassPossNoPass                                      .update_attribute(:text, '') unless @TRPassPossNoPass.blank?
    #@TRPassPossNoPassBlind                                 .update_attribute(:text, '') unless @TRPassPossNoPassBlind.blank?
    #@TRSpousePassPossNoPass                                .update_attribute(:text, '') unless @TRSpousePassPossNoPass.blank?
    #@TRSpousePassPossNoPassBlind                           .update_attribute(:text, '') unless @TRSpousePassPossNoPassBlind.blank?
    #@TRPassOther                                           .update_attribute(:text, '') unless @TRPassOther.blank?
    #@TRIrweNotUsed                                         .update_attribute(:text, '') unless @TRIrweNotUsed.blank?
    #@TRIrweNotUsedWithSEIELessThanEarn                     .update_attribute(:text, '') unless @TRIrweNotUsedWithSEIELessThanEarn.blank?
    #@TRSpouseIrweNotUsed                                   .update_attribute(:text, '') unless @TRSpouseIrweNotUsed.blank?
    #@TRSpouseIrweNotUsedWithSEIELessThanEarn               .update_attribute(:text, '') unless @TRSpouseIrweNotUsedWithSEIELessThanEarn.blank?
    #@TRBweNotUsed                                          .update_attribute(:text, '') unless @TRBweNotUsed.blank?
    #@TRBweNotUsedWithSEIELessThanEarn                      .update_attribute(:text, '') unless @TRBweNotUsedWithSEIELessThanEarn.blank?
    #@TRSpouseBweNotUsed                                    .update_attribute(:text, '') unless @TRSpouseBweNotUsed.blank?
    #@TRSpouseBweNotUsedWithSEIELessThanEarn                .update_attribute(:text, '') unless @TRSpouseBweNotUsedWithSEIELessThanEarn.blank?
    #@TRDIIrweAvail                                         .update_attribute(:text, '') unless @TRDIIrweAvail.blank?
    #@TRDISubAvail                                          .update_attribute(:text, '') unless @TRDISubAvail.blank?
    #@TREarnRecSelf                                         .update_attribute(:text, '') unless @TREarnRecSelf.blank?
    #@TREarnRecOther                                        .update_attribute(:text, '') unless @TREarnRecOther.blank?
    
  end

  def self.down
  end
end
