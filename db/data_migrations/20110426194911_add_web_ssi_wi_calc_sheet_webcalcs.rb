class AddWebSsiWiCalcSheetWebcalcs < ActiveRecord::Migration
  def self.up
    
     require 'ruby-debug'
     require 'wwweb_session_manager'
   
    @dRTotalWorkExpAmt = WebCalc.find_by_name('RTotalWorkExpAmt') 
    @dRTotalWorkExpAmt.delete unless @dRTotalWorkExpAmt.blank?
    
    @RTotalWorkExpAmt  = WebCalc.new(:name => 'RTotalWorkExpAmt')
    #DisWorkExpAmt     EstEarnTaxAmt     OthWorkExpAmt
    @RTotalWorkExpAmt.operation = "
    DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
    EstEarnTaxAmt = manager.get_answer_by_question_name('EstEarnTaxAmt')
    OthWorkExpAmt = manager.get_answer_by_question_name('OthWorkExpAmt')
    DisWorkExpAmt.to_f + EstEarnTaxAmt.to_f + OthWorkExpAmt.to_f
    "
    @RTotalWorkExpAmt.save!
    
    @delete =  WebCalc.find_by_name('RWorkExpAndInvestAmt')
    @delete.delete  unless @delete.blank?
    @RWorkExpAndInvestAmt = WebCalc.new(:name => 'RWorkExpAndInvestAmt')
    #13 RTotalWorkExpAmt + EmployInvestAmt
    @RWorkExpAndInvestAmt.operation = "
    RTotalWorkExpAmt = WebCalc.find_by_name('RTotalWorkExpAmt')
    RTotalWorkExpAmt = Float(RTotalWorkExpAmt.calculate manager)
    EmployInvestAmt = manager.get_answer_by_question_name('EmployInvestAmt')
    RTotalWorkExpAmt + EmployInvestAmt.to_f 
    "
    @RWorkExpAndInvestAmt.save!
    
    @delete =  WebCalc.find_by_name('RInvestWorkExpNotPassIrweBweAmt')
    @delete.delete unless @delete.blank?    
    @RInvestWorkExpNotPassIrweBweAmt = WebCalc.new(:name => 'RInvestWorkExpNotPassIrweBweAmt')
    #19 =MAX(0;F14-F16-F17-F18)
    #14 RWorkExpAndInvestAmt
    #16 PassAmt
    #17 SsiCaidIrweAmt
    #18 BweAmt
    
    @delete =  WebCalc.find_by_name('RInvestWorkExpNotPassIrweBweAmt')
    @delete.delete unless @delete.blank?
    @RSpouseWorkExpAndInvestAmt = WebCalc.new(:name => 'RInvestWorkExpNotPassIrweBweAmt')
    @RInvestWorkExpNotPassIrweBweAmt.operation = "
    RTotalWorkExpAmt = WebCalc.find_by_name('RTotalWorkExpAmt')
    RTotalWorkExpAmt = Float(RTotalWorkExpAmt.calculate manager)
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
    BweAmt = manager.get_answer_by_question_name('BweAmt')
    [(RTotalWorkExpAmt - PassAmt.to_f - SsiCaidIrweAmt.to_f - BweAmt.to_f) , 0].max
    "
    @RInvestWorkExpNotPassIrweBweAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseTotalWorkExpAmt')
    @delete.delete unless @delete.blank?
    @RSpouseTotalWorkExpAmt = WebCalc.new(:name => 'RSpouseTotalWorkExpAmt')
    #26 =SUM(F21:F26)
    #22 SpouseDisWorkExpAmt + #23 SpouseEstEarnTaxAmt + #24 SpouseOthWorkExpAmt
    @RSpouseTotalWorkExpAmt.operation = "
    SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
    SpouseEstEarnTaxAmt = manager.get_answer_by_question_name('SpouseEstEarnTaxAmt')
    SpouseOthWorkExpAmt = manager.get_answer_by_question_name('SpouseOthWorkExpAmt')
    SpouseDisWorkExpAmt.to_f + SpouseEstEarnTaxAmt.to_f + SpouseOthWorkExpAmt.to_f
    "
    @RSpouseTotalWorkExpAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseWorkExpAndInvestAmt')
    @delete.delete unless @delete.blank?
    @RSpouseWorkExpAndInvestAmt = WebCalc.new(:name => 'RSpouseWorkExpAndInvestAmt')
    #30 =SUM(F26:F30)  RSpouseTotalWorkExpAmt + SpouseEmployInvestAmt
    @RSpouseWorkExpAndInvestAmt.operation = "
    RSpouseTotalWorkExpAmt = WebCalc.find_by_name('RSpouseTotalWorkExpAmt')
    RSpouseTotalWorkExpAmt = Float(RSpouseTotalWorkExpAmt.calculate manager)
    SpouseEmployInvestAmt = manager.get_answer_by_question_name('SpouseEmployInvestAmt')
    RSpouseTotalWorkExpAmt + SpouseEmployInvestAmt.to_f
    "
    @RSpouseWorkExpAndInvestAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseInvestWorkExpNotPassIrweBweAmt')
    @delete.delete unless @delete.blank?
    @RSpouseInvestWorkExpNotPassIrweBweAmt = WebCalc.new(:name => 'RSpouseInvestWorkExpNotPassIrweBweAmt')
    #37 =MAX(0;F31-F33-F34-F35)
    #31 RSpouseWorkExpAndInvestAmt - SpousePassAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt
    @RSpouseInvestWorkExpNotPassIrweBweAmt.operation = "
    RSpouseWorkExpAndInvestAmt = WebCalc.find_by_name('RSpouseWorkExpAndInvestAmt')
    RSpouseWorkExpAndInvestAmt = Float(RSpouseWorkExpAndInvestAmt.calculate manager)
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
    SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
    [(RSpouseWorkExpAndInvestAmt - SpousePassAmt.to_f - SpouseSsiCaidIrweAmt.to_f - SpouseBweAmt.to_f), 0].max
    "
    @RSpouseInvestWorkExpNotPassIrweBweAmt.save!
    


    @delete =  WebCalc.find_by_name('RFbrWorkIncentivePossAmt')
    @delete.delete unless @delete.blank?
    @RFbrWorkIncentivePossAmt = WebCalc.new(:name => 'RFbrWorkIncentivePossAmt')
    #46 =IF(AND(F41+F42>0;F40="True");MIN(F44;F43);F45)
    #IF ((SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0) AND R_SsiSpousalDeemCalcsUsed = True), THEN RFbrWorkIncentivePossAmt = the lower of (RateFbrAmt or R_FbrSpouseDeemAmt), ELSE R_FbrNoSpouseDeemAmt
    #41 SsiSpouseDeemUnearnAmt
    #42 SsiSpouseDeemEarnAmt
    #40 R_SsiSpousalDeemCalcsUsed  NOte this is T/F and not currency
    #44 RateFbrAmt
    #43 R_FbrSpouseDeemAmt
    #45 R_FbrNoSpouseDeemAmt
    #debugger
    @RFbrWorkIncentivePossAmt.operation = "
    SsiSpouseDeemUnearnAmt = manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt')
    SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt')
    R_SsiSpousalDeemCalcsUsed = WebCalc.find_by_name('R_SsiSpousalDeemCalcsUsed')
    R_SsiSpousalDeemCalcsUsed = R_SsiSpousalDeemCalcsUsed.calculate manager
    RateFbrAmt = WebCalc.find_by_name('RateFbrAmt')
    RateFbrAmt = Float(RateFbrAmt.calculate manager)
    R_FbrSpouseDeemAmt = WebCalc.find_by_name('R_FbrSpouseDeemAmt')
    R_FbrSpouseDeemAmt = Float(R_FbrSpouseDeemAmt.calculate manager)
    R_FbrNoSpouseDeemAmt = WebCalc.find_by_name('R_FbrNoSpouseDeemAmt')
    R_FbrNoSpouseDeemAmt = Float(R_FbrNoSpouseDeemAmt.calculate manager)
    if ((SsiSpouseDeemUnearnAmt.to_f + SsiSpouseDeemEarnAmt.to_f) > 0) && R_SsiSpousalDeemCalcsUsed == true then
      [RateFbrAmt, R_FbrSpouseDeemAmt].min
    else
      R_FbrNoSpouseDeemAmt
    end
    "
    @RFbrWorkIncentivePossAmt.save!
    
    @delete =  WebCalc.find_by_name('CountIncForHighestUserPassReimbAmt')
    @delete.delete unless @delete.blank?
     @CountIncForHighestUserPassReimbAmt = WebCalc.new(:name => 'CountIncForHighestUserPassReimbAmt')
    #56 =MAX(0;IF(F50="False";F51-F54;F52))
    #F50 R_SsiSpousalDeemCalcsUsed
    #F51 R_TotalIncMinusBweNoSpouseDeemAmt
    #F54 SpousePassAmt
    #F52 R_TotalIncMinusBweSpouseDeemAmt
     
    @CountIncForHighestUserPassReimbAmt.operation = "
    R_SsiSpousalDeemCalcsUsed = WebCalc.find_by_name('R_SsiSpousalDeemCalcsUsed')
    R_SsiSpousalDeemCalcsUsed = R_SsiSpousalDeemCalcsUsed.calculate manager
    R_TotalIncMinusBweNoSpouseDeemAmt = WebCalc.find_by_name('R_TotalIncMinusBweNoSpouseDeemAmt')
    R_TotalIncMinusBweNoSpouseDeemAmt = Float(R_TotalIncMinusBweNoSpouseDeemAmt.calculate manager)
    R_TotalIncMinusBweSpouseDeemAmt = WebCalc.find_by_name('R_TotalIncMinusBweSpouseDeemAmt')
    R_TotalIncMinusBweSpouseDeemAmt = Float(R_TotalIncMinusBweSpouseDeemAmt.calculate manager)
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    if R_SsiSpousalDeemCalcsUsed == false then
      [(R_TotalIncMinusBweNoSpouseDeemAmt - SpousePassAmt.to_f) , 0].max
    else
      [(R_TotalIncMinusBweSpouseDeemAmt), 0].max
    end
    "
    @CountIncForHighestUserPassReimbAmt.save!
    
    @delete =  WebCalc.find_by_name('RCountIncForHighestSpousePassReimbAmt')
    @delete.delete unless @delete.blank?
  #    R_TotalIncMinusBweNoSpouseDeemAmt
     @RCountIncForHighestSpousePassReimbAmt = WebCalc.new(:name => 'RCountIncForHighestSpousePassReimbAmt')
    #58 =MAX(0;IF(F50="False";F51-F55;F52-54))  If R_SsiSpousalDeemCalcsUsed = false, THEN CountIncForHighestUserPassReimbAmt = R_TotalIncMinusBweNoSpouseDeemAmt - PassAmt, ELSE R_TotalIncMinusBweSpouseDeemAmt - PassAmt (cannot be < 0)
    #F50 R_SsiSpousalDeemCalcsUsed
    #f51 R_TotalIncMinusBweNoSpouseDeemAmt
    #f55 PassAmt
    #f52 R_TotalIncMinusBweSpouseDeemAmt
    #f54 SpousePassAmt  Note this is a typo not fixed in #38
    @RCountIncForHighestSpousePassReimbAmt.operation = "
    R_SsiSpousalDeemCalcsUsed = WebCalc.find_by_name('R_SsiSpousalDeemCalcsUsed')
    R_SsiSpousalDeemCalcsUsed = R_SsiSpousalDeemCalcsUsed.calculate manager
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    R_TotalIncMinusBweNoSpouseDeemAmt = WebCalc.find_by_name('R_TotalIncMinusBweNoSpouseDeemAmt')
    R_TotalIncMinusBweNoSpouseDeemAmt = Float(R_TotalIncMinusBweNoSpouseDeemAmt.calculate manager)
    R_TotalIncMinusBweSpouseDeemAmt = WebCalc.find_by_name('R_TotalIncMinusBweSpouseDeemAmt')
    R_TotalIncMinusBweSpouseDeemAmt = Float(R_TotalIncMinusBweSpouseDeemAmt.calculate manager)
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    if R_SsiSpousalDeemCalcsUsed == false then
      [(R_TotalIncMinusBweNoSpouseDeemAmt - PassAmt.to_f) , 0].max
    else
      [(R_TotalIncMinusBweSpouseDeemAmt - SpousePassAmt.to_f), 0].max
    end 
    "
    @RCountIncForHighestSpousePassReimbAmt.save!
    
    @delete =  WebCalc.find_by_name('RHighestUserPassReimbAvailAmt')
    @delete.delete unless @delete.blank?    
     @RHighestUserPassReimbAvailAmt = WebCalc.new(:name => 'RHighestUserPassReimbAvailAmt')
    #60 =MAX(0;F53-F57)
    #f53 RFbrWorkIncentivePossAmt
    #f57 CountIncForHighestUserPassReimbAmt
    @RHighestUserPassReimbAvailAmt.operation = "
    RFbrWorkIncentivePossAmt = WebCalc.find_by_name('RFbrWorkIncentivePossAmt')
    RFbrWorkIncentivePossAmt = Float(RFbrWorkIncentivePossAmt.calculate manager)
    CountIncForHighestUserPassReimbAmt = WebCalc.find_by_name('CountIncForHighestUserPassReimbAmt')
    CountIncForHighestUserPassReimbAmt = Float(CountIncForHighestUserPassReimbAmt.calculate manager)
    [(RFbrWorkIncentivePossAmt - CountIncForHighestUserPassReimbAmt), 0].max
    "
    @RHighestUserPassReimbAvailAmt.save!
    
    @delete =  WebCalc.find_by_name('RHighestSpousePassReimbAvailAmt')
    @delete.delete unless @delete.blank?
    @RHighestSpousePassReimbAvailAmt = WebCalc.new(:name => 'RHighestSpousePassReimbAvailAmt')
    #62 =MAX(0;F53-F59)
    #53 RFbrWorkIncentivePossAmt
    #59 RCountIncForHighestSpousePassReimbAmt
    @RHighestSpousePassReimbAvailAmt.operation = "
    RFbrWorkIncentivePossAmt = WebCalc.find_by_name('RFbrWorkIncentivePossAmt')
    RFbrWorkIncentivePossAmt = Float(RFbrWorkIncentivePossAmt.calculate manager)
    RCountIncForHighestSpousePassReimbAmt = WebCalc.find_by_name('RCountIncForHighestSpousePassReimbAmt')
    RCountIncForHighestSpousePassReimbAmt = Float(RCountIncForHighestSpousePassReimbAmt.calculate manager)
    [(RFbrWorkIncentivePossAmt - RCountIncForHighestSpousePassReimbAmt), 0].max
    "
    @RHighestSpousePassReimbAvailAmt.save!
    
    @delete =  WebCalc.find_by_name('RUnearnForSsiCalcAmt')
    @delete.delete unless @delete.blank?
    @RUnearnForSsiCalcAmt = WebCalc.new(:name => 'RUnearnForSsiCalcAmt')
    #74 =IF(F66="true";F67;F68)
    #f66 R_SsiSpousalDeemCalcsUsed
    #f67 R_UnearnForSsiCalcSpouseDeemAmt
    #f68 R_UnearnForSsiCalcNoSpouseDeemAmt
    @RUnearnForSsiCalcAmt.operation = "
    R_SsiSpousalDeemCalcsUsed = WebCalc.find_by_name('R_SsiSpousalDeemCalcsUsed')
    R_SsiSpousalDeemCalcsUsed = R_SsiSpousalDeemCalcsUsed.calculate manager
    R_UnearnForSsiCalcSpouseDeemAmt = WebCalc.find_by_name('R_UnearnForSsiCalcSpouseDeemAmt')
    R_UnearnForSsiCalcSpouseDeemAmt = Float(R_UnearnForSsiCalcSpouseDeemAmt.calculate manager)
    R_UnearnForSsiCalcNoSpouseDeemAmt = WebCalc.find_by_name('R_UnearnForSsiCalcNoSpouseDeemAmt')
    R_UnearnForSsiCalcNoSpouseDeemAmt = Float(R_UnearnForSsiCalcNoSpouseDeemAmt.calculate manager)
    if R_SsiSpousalDeemCalcsUsed == true then
      R_UnearnForSsiCalcSpouseDeemAmt
    else
      R_UnearnForSsiCalcNoSpouseDeemAmt
    end
    "
    @RUnearnForSsiCalcAmt.save!
    
    @delete =  WebCalc.find_by_name('RFbrAmt')
    @delete.delete unless @delete.blank?
    @RFbrAmt = WebCalc.new(:name => 'RFbrAmt')
    #75 =IF(F66="true";F71;F72)
    #66 R_SsiSpousalDeemCalcsUsed
    #F71 R_FbrSpouseDeemAmt
    #F72 R_FbrNoSpouseDeemAmt
    @RFbrAmt.operation = "
    R_SsiSpousalDeemCalcsUsed = WebCalc.find_by_name('R_SsiSpousalDeemCalcsUsed')
    R_SsiSpousalDeemCalcsUsed = R_SsiSpousalDeemCalcsUsed.calculate manager
    R_FbrSpouseDeemAmt = WebCalc.find_by_name('R_FbrSpouseDeemAmt')
    R_FbrSpouseDeemAmt = Float(R_FbrSpouseDeemAmt.calculate manager)
    R_FbrNoSpouseDeemAmt = WebCalc.find_by_name('R_FbrNoSpouseDeemAmt')
    R_FbrNoSpouseDeemAmt = Float(R_FbrNoSpouseDeemAmt.calculate manager)
    if R_SsiSpousalDeemCalcsUsed == true then
      R_FbrSpouseDeemAmt
    else
      R_FbrNoSpouseDeemAmt    
    end    
    "
    @RFbrAmt.save!
    
    @delete =  WebCalc.find_by_name('RUnearnMinusFbrAmt')
    @delete.delete unless @delete.blank?
    @RUnearnMinusFbrAmt = WebCalc.new(:name => 'RUnearnMinusFbrAmt')
    #76 =F75-F76
    #F75 RUnearnForSsiCalcAmt
    #F76 RFbrAmt
    @RUnearnMinusFbrAmt.operation = "
    RUnearnForSsiCalcAmt = WebCalc.find_by_name('RUnearnForSsiCalcAmt')
    RUnearnForSsiCalcAmt = Float(RUnearnForSsiCalcAmt.calculate manager)
    RFbrAmt = WebCalc.find_by_name('RFbrAmt')
    RFbrAmt = Float(RFbrAmt.calculate manager)
    RUnearnForSsiCalcAmt - RFbrAmt
    "
    @RUnearnMinusFbrAmt.save!
    
    @delete =  WebCalc.find_by_name('RSsiUnearnEligTotPassNeedAmt')
    @delete.delete unless @delete.blank?
    @RSsiUnearnEligTotPassNeedAmt = WebCalc.new(:name => 'RSsiUnearnEligTotPassNeedAmt')
    #78 =IF(F77>0;F77+1;0)
    #F77 RUnearnMinusFbrAmt
    @RSsiUnearnEligTotPassNeedAmt.operation = "
    RUnearnMinusFbrAmt = WebCalc.find_by_name('RUnearnMinusFbrAmt')
    RUnearnMinusFbrAmt = Float(RUnearnMinusFbrAmt.calculate manager)
    if RUnearnMinusFbrAmt > 0 then
      RUnearnMinusFbrAmt + 1
    else
      0
    end
    "
    @RSsiUnearnEligTotPassNeedAmt.save!
    
    @delete =  WebCalc.find_by_name('RSsiUnearnEligAddedPassNeedAmt')
    @delete.delete unless @delete.blank?
    @RSsiUnearnEligAddedPassNeedAmt = WebCalc.new(:name => 'RSsiUnearnEligAddedPassNeedAmt')
    #80 =MAX(0;F79-(F69+F70))
    #f79  RSsiUnearnEligTotPassNeedAmt
    #F69  PassAmt
    #f70  SpousePassAmt
    @RSsiUnearnEligAddedPassNeedAmt.operation = "
    RSsiUnearnEligTotPassNeedAmt = WebCalc.find_by_name('RSsiUnearnEligTotPassNeedAmt')
    RSsiUnearnEligTotPassNeedAmt = Float(RSsiUnearnEligTotPassNeedAmt.calculate manager)
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    [(RSsiUnearnEligTotPassNeedAmt - (PassAmt.to_f + SpousePassAmt.to_f)), 0].max
    "
    @RSsiUnearnEligAddedPassNeedAmt.save!
    
    @delete =  WebCalc.find_by_name('REarnNoIrweNoDivideAmt')
    @delete.delete unless @delete.blank?
    @REarnNoIrweNoDivideAmt = WebCalc.new(:name => 'REarnNoIrweNoDivideAmt')
    #90 =IF(F87="False";F85;F86) IF R_SsiSpousalDeemCalcsUsed = False, THEN REarnNoIrweNoDivideAmt = R_EarnBeforeDivideNoSpouseDeemAmt ELSE R_EarnBeforeDivideSpouseDeemAmt
    #F87 R_SsiSpousalDeemCalcsUsed
    #F85 R_EarnBeforeDivideNoSpouseDeemAmt
    #f86 R_EarnBeforeDivideSpouseDeemAmt     
    @REarnNoIrweNoDivideAmt.operation = "
    R_SsiSpousalDeemCalcsUsed = WebCalc.find_by_name('R_SsiSpousalDeemCalcsUsed')
    R_SsiSpousalDeemCalcsUsed = R_SsiSpousalDeemCalcsUsed.calculate manager
    R_EarnBeforeDivideNoSpouseDeemAmt = WebCalc.find_by_name('R_EarnBeforeDivideNoSpouseDeemAmt')
    R_EarnBeforeDivideNoSpouseDeemAmt = Float(R_EarnBeforeDivideNoSpouseDeemAmt.calculate manager)
    R_EarnBeforeDivideSpouseDeemAmt = WebCalc.find_by_name('R_EarnBeforeDivideSpouseDeemAmt')
    R_EarnBeforeDivideSpouseDeemAmt = Float(R_EarnBeforeDivideSpouseDeemAmt.calculate manager)
    if R_SsiSpousalDeemCalcsUsed == false then
      R_EarnBeforeDivideNoSpouseDeemAmt
    else
      R_EarnBeforeDivideSpouseDeemAmt
    end
    "
    @REarnNoIrweNoDivideAmt.save!
    
    @delete =  WebCalc.find_by_name('REarnMinusSpouseIrweNoDivideAmt')
    @delete.delete unless @delete.blank?
    @REarnMinusSpouseIrweNoDivideAmt = WebCalc.new(:name => 'REarnMinusSpouseIrweNoDivideAmt')
    #92 =F91-F88 REarnMinusSpouseIrweNoDivideAmt = REarnNoIrweNoDivideAmt - SpouseSsiCaidIrweAmt
    @REarnMinusSpouseIrweNoDivideAmt.operation = "
    REarnNoIrweNoDivideAmt = WebCalc.find_by_name('REarnNoIrweNoDivideAmt')
    REarnNoIrweNoDivideAmt = Float(REarnNoIrweNoDivideAmt.calculate manager)
    SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
    REarnNoIrweNoDivideAmt - SpouseSsiCaidIrweAmt.to_f
    "
    @REarnMinusSpouseIrweNoDivideAmt.save!
    
    @delete =  WebCalc.find_by_name('RCountEarnMinusSpouseIrweDivideNoBweAmt')
    @delete.delete unless @delete.blank?
    @RCountEarnMinusSpouseIrweDivideNoBweAmt = WebCalc.new(:name => 'RCountEarnMinusSpouseIrweDivideNoBweAmt')
    #94 =F93/2 Countable Earned Income after subtracting Spouse's IRWE and after dividing by 2 but before subtracting Spouse  BWE
    #f93 REarnMinusSpouseIrweNoDivideAmt
    @RCountEarnMinusSpouseIrweDivideNoBweAmt.operation = "
    REarnMinusSpouseIrweNoDivideAmt = WebCalc.find_by_name('REarnMinusSpouseIrweNoDivideAmt')
    REarnMinusSpouseIrweNoDivideAmt = Float(REarnMinusSpouseIrweNoDivideAmt.calculate manager) 
    (REarnMinusSpouseIrweNoDivideAmt/2)
    "
    @RCountEarnMinusSpouseIrweDivideNoBweAmt.save!
    
    @delete =  WebCalc.find_by_name('REarnMinusSpouseIrweBweAmt')
    @delete.delete unless @delete.blank?
    @REarnMinusSpouseIrweBweAmt = WebCalc.new(:name => 'REarnMinusSpouseIrweBweAmt')
    #98 =F95-F97 Countable Earned Income after subtracting Spouse's IRWE, dividing by 2, and subtracting Spouse BWE (can not be less than zero)
    #f95 RCountEarnMinusSpouseIrweDivideNoBweAmt
    #f97 SpouseBweAmt
    @REarnMinusSpouseIrweBweAmt.operation = "
    RCountEarnMinusSpouseIrweDivideNoBweAmt = WebCalc.find_by_name('RCountEarnMinusSpouseIrweDivideNoBweAmt')
    RCountEarnMinusSpouseIrweDivideNoBweAmt = Float(RCountEarnMinusSpouseIrweDivideNoBweAmt.calculate manager)
    SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
    RCountEarnMinusSpouseIrweDivideNoBweAmt - SpouseBweAmt.to_f 
    "
    @REarnMinusSpouseIrweBweAmt.save!
    
    @delete =  WebCalc.find_by_name('REarnMinusUserIrweNoDivideAmt')
    @delete.delete unless @delete.blank?
    @REarnMinusUserIrweNoDivideAmt = WebCalc.new(:name => 'REarnMinusUserIrweNoDivideAmt')
    #105 =F102-F103 REarnMinusUserIrweNoDivideAmt = REarnNoIrweNoDivideAmt - SsiCaidIrweAmt
    @REarnMinusUserIrweNoDivideAmt.operation = "
    REarnNoIrweNoDivideAmt = WebCalc.find_by_name('REarnNoIrweNoDivideAmt')
    REarnNoIrweNoDivideAmt = Float(REarnNoIrweNoDivideAmt.calculate manager)
    SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
    REarnNoIrweNoDivideAmt - SsiCaidIrweAmt.to_f
    "
    @REarnMinusUserIrweNoDivideAmt.save!
    
    @delete =  WebCalc.find_by_name('REarnMinusUserIrweDivideNoBweAmt')
    @delete.delete unless @delete.blank?
    @REarnMinusUserIrweDivideNoBweAmt = WebCalc.new(:name => 'REarnMinusUserIrweDivideNoBweAmt')
    #106 =F106/2 REarnMinusUserIrweDivideNoBweAmt = REarnMinusUserIrweNoDivideAmt / 2
    @REarnMinusUserIrweDivideNoBweAmt.operation = "
    REarnMinusUserIrweNoDivideAmt = WebCalc.find_by_name('REarnMinusUserIrweNoDivideAmt')
    REarnMinusUserIrweNoDivideAmt = Float(REarnMinusUserIrweNoDivideAmt.calculate manager)
    (REarnMinusUserIrweNoDivideAmt/2)
    "
    @REarnMinusUserIrweDivideNoBweAmt.save!
    
    @delete =  WebCalc.find_by_name('REarnMinusUserIrweBweAmt')
    @delete.delete unless @delete.blank?
    @REarnMinusUserIrweBweAmt = WebCalc.new(:name => 'REarnMinusUserIrweBweAmt')
    #107 =F107-F104 REarnMinusUserIrweBweAmt = REarnMinusUserIrweDivideNoBweAmt - BweAmt
    @REarnMinusUserIrweBweAmt.operation = "
    REarnMinusUserIrweDivideNoBweAmt = WebCalc.find_by_name('REarnMinusUserIrweDivideNoBweAmt')
    REarnMinusUserIrweDivideNoBweAmt = Float(REarnMinusUserIrweDivideNoBweAmt.calculate manager)
    BweAmt = manager.get_answer_by_question_name('BweAmt')
    (REarnMinusUserIrweDivideNoBweAmt - BweAmt.to_f)
    "
    @REarnMinusUserIrweBweAmt.save!
    
    @delete =  WebCalc.find_by_name('RIrweNeededForSsiSgaTestAmt')
    @delete.delete unless @delete.blank?
    @RIrweNeededForSsiSgaTestAmt = WebCalc.new(:name => 'RIrweNeededForSsiSgaTestAmt')
    #117 =MAX(0;F112-F113) RIrweNeededForSsiSgaTestAmt = SsiOrCaidEarnAmt - R_SgaAmt (cannot be < 0)
    @RIrweNeededForSsiSgaTestAmt.operation = "
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    R_SgaAmt = WebCalc.find_by_name('R_SgaAmt')
    R_SgaAmt = Float(R_SgaAmt.calculate manager)
    [(SsiOrCaidEarnAmt.to_f - R_SgaAmt), 0].max
    "
    @RIrweNeededForSsiSgaTestAmt.save!
    
    @delete =  WebCalc.find_by_name('RAddedIrweNeededForSsiSgaTestAmt')
    @delete.delete unless @delete.blank?
    @RAddedIrweNeededForSsiSgaTestAmt = WebCalc.new(:name => 'RAddedIrweNeededForSsiSgaTestAmt')
    #118 =MAX(0;F118-F114) RAddedIrweNeededForSsiSgaTestAmt = RIrweNeededForSsiSgaTestAmt - SgaIrweAmt (cannot be < 0)
    @RAddedIrweNeededForSsiSgaTestAmt.operation = "
    RIrweNeededForSsiSgaTestAmt = WebCalc.find_by_name('RIrweNeededForSsiSgaTestAmt')
    RIrweNeededForSsiSgaTestAmt = Float(RIrweNeededForSsiSgaTestAmt.calculate manager)
    SgaIrweAmt = manager.get_answer_by_question_name('SgaIrweAmt')
    [(RIrweNeededForSsiSgaTestAmt - SgaIrweAmt.to_f), 0].max
    "
    @RAddedIrweNeededForSsiSgaTestAmt.save!
    
    @delete =  WebCalc.find_by_name('RIrweSubsidyNeededForDiSgaTestAmt')
    @delete.delete unless @delete.blank?
    @RIrweSubsidyNeededForDiSgaTestAmt = WebCalc.new(:name => 'RIrweSubsidyNeededForDiSgaTestAmt')
    #119 =MAX(0;F111-F113) RIrweSubsidyNeededForDiSgaTestAmt = SsdiEarnAmt - R_SgaAmt (cannot be < 0)
    @RIrweSubsidyNeededForDiSgaTestAmt.operation = "
    SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
    R_SgaAmt = WebCalc.find_by_name('R_SgaAmt')
    R_SgaAmt = Float(R_SgaAmt.calculate manager)
    [(SsdiEarnAmt.to_f - R_SgaAmt), 0].max
    "
    @RIrweSubsidyNeededForDiSgaTestAmt.save!
    
    @delete =  WebCalc.find_by_name('RAddedIrweSubsidyNeededForDiSgaTestAmt')
    @delete.delete unless @delete.blank?
    @RAddedIrweSubsidyNeededForDiSgaTestAmt = WebCalc.new(:name => 'RAddedIrweSubsidyNeededForDiSgaTestAmt')
    #120 =MAX(0;F120-F114)  RAddedIrweSubsidyNeededForDiSgaTestAmt = RIrweSubsidyNeededForDiSgaTestAmt - SgaIrweAmt - SubsidyEmpSupAmt - SubsidyWkDutiesReducAmt (cannot be < 0)
    @RAddedIrweSubsidyNeededForDiSgaTestAmt.operation = "
    RIrweSubsidyNeededForDiSgaTestAmt = WebCalc.find_by_name('RIrweSubsidyNeededForDiSgaTestAmt')
    RIrweSubsidyNeededForDiSgaTestAmt = Float(RIrweSubsidyNeededForDiSgaTestAmt.calculate manager)
    SgaIrweAmt = manager.get_answer_by_question_name('SgaIrweAmt')
    SubsidyEmpSupAmt = manager.get_answer_by_question_name('SubsidyEmpSupAmt')
    SubsidyWkDutiesReducAmt = manager.get_answer_by_question_name('SubsidyWkDutiesReducAmt')
    [(RIrweSubsidyNeededForDiSgaTestAmt - SgaIrweAmt.to_f - SubsidyEmpSupAmt.to_f - SubsidyWkDutiesReducAmt.to_f), 0].max
    "
    @RAddedIrweSubsidyNeededForDiSgaTestAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseIrweNeededForSsiSgaTestAmt')
    @delete.delete unless @delete.blank?
    @RSpouseIrweNeededForSsiSgaTestAmt = WebCalc.new(:name => 'RSpouseIrweNeededForSsiSgaTestAmt')
    #130 =MAX(0;F125-F126) RSpouseIrweNeededForSsiSgaTestAmt = SpouseSsiOrCaidEarnAmt - R_SgaAmt (cannot be < 0)
    @RSpouseIrweNeededForSsiSgaTestAmt.operation = "
    SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
    R_SgaAmt = WebCalc.find_by_name('R_SgaAmt')
    R_SgaAmt = Float(R_SgaAmt.calculate manager)
    [(SpouseSsiOrCaidEarnAmt.to_f - R_SgaAmt), 0].max
    "
    @RSpouseIrweNeededForSsiSgaTestAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseAddedIrweNeededForSsiSgaTestAmt')
    @delete.delete unless @delete.blank?
    @RSpouseAddedIrweNeededForSsiSgaTestAmt = WebCalc.new(:name => 'RSpouseAddedIrweNeededForSsiSgaTestAmt')
    #131 =MAX(0;F131-F127) RSpouseAddedIrweNeededForSsiSgaTestAmt = RSpouseIrweNeededForSsiSgaTestAmt - SpouseSgaIrweAmt (cannot be < 0)
    @RSpouseAddedIrweNeededForSsiSgaTestAmt.operation = "
    RSpouseIrweNeededForSsiSgaTestAmt = WebCalc.find_by_name('RSpouseIrweNeededForSsiSgaTestAmt')
    RSpouseIrweNeededForSsiSgaTestAmt = Float(RSpouseIrweNeededForSsiSgaTestAmt.calculate manager)
    SpouseSgaIrweAmt = manager.get_answer_by_question_name('SpouseSgaIrweAmt')
    [(RSpouseIrweNeededForSsiSgaTestAmt - SpouseSgaIrweAmt.to_f), 0].max
    "
    @RSpouseAddedIrweNeededForSsiSgaTestAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseIrweSubsidyNeededForDiSgaTestAmt')
    @delete.delete unless @delete.blank?
    @RSpouseIrweSubsidyNeededForDiSgaTestAmt = WebCalc.new(:name => 'RSpouseIrweSubsidyNeededForDiSgaTestAmt')
    #132 =MAX(0;F124-F126) RSpouseIrweSubsidyNeededForDiSgaTestAmt = SpouseSsdiEarnAmt - R_SgaAmt (cannot be < 0)
    @RSpouseIrweSubsidyNeededForDiSgaTestAmt.operation = "
    SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt')
    R_SgaAmt = WebCalc.find_by_name('R_SgaAmt')
    R_SgaAmt = Float(R_SgaAmt.calculate manager)
    [(SpouseSsdiEarnAmt.to_f - R_SgaAmt), 0].max
    "
    @RSpouseIrweSubsidyNeededForDiSgaTestAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt')
    @delete.delete unless @delete.blank?
    @RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt = WebCalc.new(:name => 'RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt')
    #133 =MAX(0;F133-F127) RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt = RSpouseIrweSubsidyNeededForDiSgaTestAmt - SpouseSgaIrweAmt - SpouseSubsidyEmpSupAmt - SpouseSubsidyWkDutiesReducAmt (cannot be < 0)
    #note looks like a miss in the workbook, going with description rather than formula, email sent on 4/27/2011
    @RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt.operation = "
    RSpouseIrweSubsidyNeededForDiSgaTestAmt = WebCalc.find_by_name('RSpouseIrweSubsidyNeededForDiSgaTestAmt')
    RSpouseIrweSubsidyNeededForDiSgaTestAmt = Float(RSpouseIrweSubsidyNeededForDiSgaTestAmt.calculate manager)
    SpouseSgaIrweAmt = manager.get_answer_by_question_name('SpouseSgaIrweAmt')
    SpouseSubsidyEmpSupAmt = manager.get_answer_by_question_name('SpouseSubsidyEmpSupAmt')
    SpouseSubsidyWkDutiesReducAmt = manager.get_answer_by_question_name('SpouseSubsidyWkDutiesReducAmt')
    [(RSpouseIrweSubsidyNeededForDiSgaTestAmt - SpouseSgaIrweAmt.to_f - SpouseSubsidyEmpSupAmt.to_f - SpouseSubsidyWkDutiesReducAmt.to_f), 0].max
    "
    @RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt.save!
    
    @delete =  WebCalc.find_by_name('RDisWorkExpNotIrwePassAmt')
    @delete.delete unless @delete.blank?
    @RDisWorkExpNotIrwePassAmt = WebCalc.new(:name => 'RDisWorkExpNotIrwePassAmt')
    #140 =MAX(0;F136-F138-F139) Amount of disability-related work expenses not covered under an IRWE or PASS (Can not be less than zero)
    #F136 DisWorkExpAmt
    #F138 SsiCaidIrweAmt
    #F139 PassAmt
    @RDisWorkExpNotIrwePassAmt.operation = "
    DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
    SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    [(DisWorkExpAmt.to_f - SsiCaidIrweAmt.to_f - PassAmt.to_f), 0].max
    "
    @RDisWorkExpNotIrwePassAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseDisWorkExpNotIrwePassAmt')
    @delete.delete unless @delete.blank?
    @RSpouseDisWorkExpNotIrwePassAmt = WebCalc.new(:name => 'RSpouseDisWorkExpNotIrwePassAmt')
    #147 =MAX(0;F143-F145-F146) Amount of disability-related work expenses not covered under an IRWE or PASS (Can not be less than zero)
    #f143 SpouseDisWorkExpAmt
    #F145 SpouseSsiCaidIrweAmt
    #F146 SpousePassAmt
    @RSpouseDisWorkExpNotIrwePassAmt.operation = "
    SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
    SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    [(SpouseDisWorkExpAmt.to_f - SpouseSsiCaidIrweAmt.to_f - SpousePassAmt.to_f), 0].max
    "
    @RSpouseDisWorkExpNotIrwePassAmt.save!
    
    @delete =  WebCalc.find_by_name('R_UnearnForSsiCalcAmt')
    @delete.delete unless @delete.blank?
    @R_UnearnForSsiCalcAmt = WebCalc.new(:name => 'R_UnearnForSsiCalcAmt')
    #156 =IF(F152="True"; F154;F153) IF R_SsiSpousalDeemCalcsUsed = True, THEN R_UnearnForSsiCalcAmt = R_UnearnForSsiCalcSpouseDeemAmt, ELSE R_UnearnForSsiCalcAmt
    #f153 R_UnearnForSsiCalcNoSpouseDeemAmt
    @R_UnearnForSsiCalcAmt.operation = "
    R_SsiSpousalDeemCalcsUsed = WebCalc.find_by_name('R_SsiSpousalDeemCalcsUsed')
    R_SsiSpousalDeemCalcsUsed = R_SsiSpousalDeemCalcsUsed.calculate manager
    R_UnearnForSsiCalcSpouseDeemAmt = WebCalc.find_by_name('R_UnearnForSsiCalcSpouseDeemAmt')
    R_UnearnForSsiCalcSpouseDeemAmt = Float(R_UnearnForSsiCalcSpouseDeemAmt.calculate manager)
    R_UnearnForSsiCalcNoSpouseDeemAmt = WebCalc.find_by_name('R_UnearnForSsiCalcNoSpouseDeemAmt')
    R_UnearnForSsiCalcNoSpouseDeemAmt = Float(R_UnearnForSsiCalcNoSpouseDeemAmt.calculate manager)
   if R_SsiSpousalDeemCalcsUsed == true then
     R_UnearnForSsiCalcSpouseDeemAmt
   else
     R_UnearnForSsiCalcNoSpouseDeemAmt
   end
   "
    @R_UnearnForSsiCalcAmt.save!
    
    @delete =  WebCalc.find_by_name('RMaxSsiCheckWithIrweBweAmt')
    @delete.delete unless @delete.blank?
    @RMaxSsiCheckWithIrweBweAmt = WebCalc.new(:name => 'RMaxSsiCheckWithIrweBweAmt')
    #158 =MAX(0;F151-F157) RMaxSsiCheckWithIrweBweAmt = RFbrWorkIncentivePossAmt - R_UnearnForSsiCalcAmt (cannot be < 0)
    @RMaxSsiCheckWithIrweBweAmt.operation = "
    RFbrWorkIncentivePossAmt = WebCalc.find_by_name('RFbrWorkIncentivePossAmt')
    RFbrWorkIncentivePossAmt = Float(RFbrWorkIncentivePossAmt.calculate manager)
    R_UnearnForSsiCalcAmt = WebCalc.find_by_name('R_UnearnForSsiCalcAmt')
    R_UnearnForSsiCalcAmt = Float(R_UnearnForSsiCalcAmt.calculate manager)
    [(RFbrWorkIncentivePossAmt - R_UnearnForSsiCalcAmt), 0].max
    "
    @RMaxSsiCheckWithIrweBweAmt.save!
    
    @delete =  WebCalc.find_by_name('RMaxReimbPossWithIrweAmt')
    @delete.delete unless @delete.blank?
    @RMaxReimbPossWithIrweAmt = WebCalc.new(:name => 'RMaxReimbPossWithIrweAmt')
    #160 =MIN(F159;F155) RMaxReimbPossWithIrweAmt =  the smaller of RMaxSsiCheckWithIrweBweAmt or REarnMinusSpouseIrweBweAmt
    @RMaxReimbPossWithIrweAmt.operation = "
    RMaxSsiCheckWithIrweBweAmt = WebCalc.find_by_name('RMaxSsiCheckWithIrweBweAmt')
    RMaxSsiCheckWithIrweBweAmt = Float(RMaxSsiCheckWithIrweBweAmt.calculate manager)
    REarnMinusSpouseIrweBweAmt = WebCalc.find_by_name('REarnMinusSpouseIrweBweAmt')
    REarnMinusSpouseIrweBweAmt = Float(REarnMinusSpouseIrweBweAmt.calculate manager)
   [RMaxSsiCheckWithIrweBweAmt, REarnMinusSpouseIrweBweAmt].min
    "
    @RMaxReimbPossWithIrweAmt.save!
    
    @delete =  WebCalc.find_by_name('RIrweForMaxReimbPossAmt')
    @delete.delete unless @delete.blank?
    @RIrweForMaxReimbPossAmt = WebCalc.new(:name => 'RIrweForMaxReimbPossAmt')
    #162 =F155*2  RIrweForMaxReimbPossAmt = 2 * REarnMinusSpouseIrweBweAmt
    @RIrweForMaxReimbPossAmt.operation = "
    REarnMinusSpouseIrweBweAmt = WebCalc.find_by_name('REarnMinusSpouseIrweBweAmt')
    REarnMinusSpouseIrweBweAmt = Float(REarnMinusSpouseIrweBweAmt.calculate manager)
    (REarnMinusSpouseIrweBweAmt * 2)
    "
    @RIrweForMaxReimbPossAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseMaxReimbPossWithIrweAmt')
    @delete.delete unless @delete.blank?
    @RSpouseMaxReimbPossWithIrweAmt = WebCalc.new(:name => 'RSpouseMaxReimbPossWithIrweAmt')
    #168 =MIN(F166;F167) RSpouseMaxReimbPossWithIrweAmt = smaller of RMaxSsiCheckWithIrweBweAmt OR REarnMinusUserIrweBweAmt
    @RSpouseMaxReimbPossWithIrweAmt.operation = "
    RMaxSsiCheckWithIrweBweAmt = WebCalc.find_by_name('RMaxSsiCheckWithIrweBweAmt')
    RMaxSsiCheckWithIrweBweAmt = Float(RMaxSsiCheckWithIrweBweAmt.calculate manager)
    REarnMinusUserIrweBweAmt = WebCalc.find_by_name('REarnMinusUserIrweBweAmt')
    REarnMinusUserIrweBweAmt = Float(REarnMinusUserIrweBweAmt.calculate manager)
    [RMaxSsiCheckWithIrweBweAmt, REarnMinusUserIrweBweAmt].min
    "
    @RSpouseMaxReimbPossWithIrweAmt.save!
    
    @delete =  WebCalc.find_by_name('RIrweForMaxReimbPossAmt')
    @delete.delete unless @delete.blank?
    @RIrweForMaxReimbPossAmt = WebCalc.new(:name => 'RIrweForMaxReimbPossAmt')
    #170 =F167*2 RIrweForMaxReimbPossAmt = 2 * REarnMinusUserIrweBweAmt
    @RIrweForMaxReimbPossAmt.operation = "
    REarnMinusUserIrweBweAmt = WebCalc.find_by_name('REarnMinusUserIrweBweAmt')
    REarnMinusUserIrweBweAmt = Float(REarnMinusUserIrweBweAmt.calculate manager)
    (REarnMinusUserIrweBweAmt * 2)
    "
    @RIrweForMaxReimbPossAmt.save!
    
    @delete =  WebCalc.find_by_name('RTotWorkExpAmt')
    @delete.delete unless @delete.blank?
    @RTotWorkExpAmt = WebCalc.new(:name => 'RTotWorkExpAmt')
    #181 =F175+F176+F177 RTotWorkExpAmt = DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt
    @RTotWorkExpAmt.operation = "
    DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
    EstEarnTaxAmt = manager.get_answer_by_question_name('EstEarnTaxAmt')
    OthWorkExpAmt = manager.get_answer_by_question_name('OthWorkExpAmt')
    (DisWorkExpAmt.to_f + EstEarnTaxAmt.to_f + OthWorkExpAmt.to_f)
    "
    @RTotWorkExpAmt.save!
    
    @delete =  WebCalc.find_by_name('RWorkExpNotBweOrPassAmt')
    @delete.delete unless @delete.blank?
    @RWorkExpNotBweOrPassAmt = WebCalc.new(:name => 'RWorkExpNotBweOrPassAmt')
    #183 =MAX(0;F182-F179-F180) RWorkExpNotBweOrPassAmt = RTotWorkExpAmt - BweAmt - (PassAmt - EmployInvestAmt) (cannot be < 0)
    ##### Note this needs to be reviewed the calcs are different than description
    @RWorkExpNotBweOrPassAmt.operation = "
    RTotWorkExpAmt = WebCalc.find_by_name('RTotWorkExpAmt')
    RTotWorkExpAmt = Float(RTotWorkExpAmt.calculate manager)
    BweAmt = manager.get_answer_by_question_name('BweAmt')
    PassAmt = manager.get_answer_by_question_name('PassAmt')
    EmployInvestAmt = manager.get_answer_by_question_name('EmployInvestAmt')
    [(RTotWorkExpAmt - BweAmt.to_f - [(PassAmt.to_f - EmployInvestAmt.to_f), 0].min), 0].max
    "
    @RWorkExpNotBweOrPassAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseTotWorkExpAmt')
    @delete.delete unless @delete.blank?
    @RSpouseTotWorkExpAmt = WebCalc.new(:name => 'RSpouseTotWorkExpAmt')
    #193 =F187+F188+F189 RSpouseTotWorkExpAmt = SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt
    @RSpouseTotWorkExpAmt.operation = "
    SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
    SpouseEstEarnTaxAmt = manager.get_answer_by_question_name('SpouseEstEarnTaxAmt')
    SpouseOthWorkExpAmt = manager.get_answer_by_question_name('SpouseOthWorkExpAmt')
    (SpouseDisWorkExpAmt.to_f + SpouseEstEarnTaxAmt.to_f + SpouseOthWorkExpAmt.to_f)
    "
    @RSpouseTotWorkExpAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseWorkExpNotBweOrPassAmt')
    @delete.delete unless @delete.blank?
    @RSpouseWorkExpNotBweOrPassAmt = WebCalc.new(:name => 'RSpouseWorkExpNotBweOrPassAmt')
    #195 =MAX(0;F194-F191-F192) RSpouseWorkExpNotBweOrPassAmt = RSpouseTotWorkExpAmt - SpouseBweAmt - (SpousePassAmt - SpouseEmployInvestAmt) (cannot be < 0)
    #NOte another reviewable one Bob partial possible fix based on call
    @RSpouseWorkExpNotBweOrPassAmt.operation = "
    RSpouseTotWorkExpAmt = WebCalc.find_by_name('RSpouseTotWorkExpAmt')
    RSpouseTotWorkExpAmt = Float(RSpouseTotWorkExpAmt.calculate manager)
    SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    SpouseEmployInvestAmt = manager.get_answer_by_question_name('SpouseEmployInvestAmt')
    [(RSpouseTotWorkExpAmt - SpouseBweAmt.to_f - [(SpousePassAmt.to_f - SpouseEmployInvestAmt.to_f), 0].min), 0].max
    "
    @RSpouseWorkExpNotBweOrPassAmt.save!
    
    @delete =  WebCalc.find_by_name('RTotBweReimbAvail')
    @delete.delete unless @delete.blank?
    @RTotBweReimbAvail = WebCalc.new(:name => 'RTotBweReimbAvail')
    #201 =MIN(F198;F200) Total amount of reimbursement available with use of a BWE
    #f198 RMaxSsiCheckWithIrweBweAmt
    #f200 REarnMinusSpouseIrweBweAmt
    @RTotBweReimbAvail.operation = "
    RMaxSsiCheckWithIrweBweAmt = WebCalc.find_by_name('RMaxSsiCheckWithIrweBweAmt')
    RMaxSsiCheckWithIrweBweAmt = Float(RMaxSsiCheckWithIrweBweAmt.calculate manager)
    REarnMinusSpouseIrweBweAmt = WebCalc.find_by_name('REarnMinusSpouseIrweBweAmt')
    REarnMinusSpouseIrweBweAmt = Float(REarnMinusSpouseIrweBweAmt.calculate manager)
    [RMaxSsiCheckWithIrweBweAmt, REarnMinusSpouseIrweBweAmt].min
    "
    @RTotBweReimbAvail.save!
    
    @delete =  WebCalc.find_by_name('RSpouseTotBweReimbAvail')
    @delete.delete unless @delete.blank?
    @RSpouseTotBweReimbAvail = WebCalc.new(:name => 'RSpouseTotBweReimbAvail')
    #212 =MIN(F209;F211) Total amount of reimbursement available with use of a BWE
    #f209 RMaxSsiCheckWithIrweBweAmt
    #f211 REarnMinusUserIrweBweAmt
    @RSpouseTotBweReimbAvail.operation = "
    RMaxSsiCheckWithIrweBweAmt = WebCalc.find_by_name('RMaxSsiCheckWithIrweBweAmt')
    RMaxSsiCheckWithIrweBweAmt = Float(RMaxSsiCheckWithIrweBweAmt.calculate manager)
    REarnMinusUserIrweBweAmt = WebCalc.find_by_name('REarnMinusUserIrweBweAmt')
    REarnMinusUserIrweBweAmt = Float(REarnMinusUserIrweBweAmt.calculate manager)
    [RMaxSsiCheckWithIrweBweAmt, REarnMinusUserIrweBweAmt].min
    "
    @RSpouseTotBweReimbAvail.save!
    
    @delete =  WebCalc.find_by_name('RSSIEarnSpouseEarnOrDeemAmt')
    @delete.delete unless @delete.blank?
    @RSSIEarnSpouseEarnOrDeemAmt = WebCalc.new(:name => 'RSSIEarnSpouseEarnOrDeemAmt')
    #229 =(IF(F221="YES";F223;0))+(IF(F222="YES";F224+F225;0)) RSSIEarnSpouseEarnOrDeemAmt = (IF Student = YES, THEN SsiOrCaidEarnAmt, ELSE 0) + (IF SpouseStudent = YES, THEN SpouseSsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt, ELSE 0)
    @RSSIEarnSpouseEarnOrDeemAmt.operation = "
    Student = manager.get_answer_by_question_name('Student')
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
    SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
    SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt')
    returnVar = 0
    if Student == 'Yes' then
      returnVar = SsiOrCaidEarnAmt.to_f
    end
    if SpouseStudent ==  'Yes' then
      returnVar = returnVar +  SpouseSsiOrCaidEarnAmt.to_f + SsiSpouseDeemEarnAmt.to_f
    end
    returnVar    
    "
    @RSSIEarnSpouseEarnOrDeemAmt.save!
    
    @delete =  WebCalc.find_by_name('RSEIEPossAmt')
    @delete.delete unless @delete.blank?
    @RSEIEPossAmt = WebCalc.new(:name => 'RSEIEPossAmt')
    #231 =MIN(F230;F226) RSEIEPossAmt = Minimum of RSSIEarnSpouseEarnOrDeemAmt AND RateSEIEMaxMonthly
    @RSEIEPossAmt.operation = "
    RSSIEarnSpouseEarnOrDeemAmt = WebCalc.find_by_name('RSSIEarnSpouseEarnOrDeemAmt')
    RSSIEarnSpouseEarnOrDeemAmt = Float(RSSIEarnSpouseEarnOrDeemAmt.calculate manager)
    RateSEIEMaxMonthly = 1640
    unless manager.get_answer_by_question_name('SitDate').blank? 
        SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')

        rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
        if !(rate.blank?) then
          RateSEIEMaxMonthly = rate.seie_max_monthly
        end
    end
    [RSSIEarnSpouseEarnOrDeemAmt, RateSEIEMaxMonthly].min
    "
    @RSEIEPossAmt.save!
    
    @delete =  WebCalc.find_by_name('RAddSEIEAmt')
    @delete.delete unless @delete.blank?
    @RAddSEIEAmt = WebCalc.new(:name => 'RAddSEIEAmt')
    #233 =F232-(F227+F228) RAddSEIEAmt = RSEIEPossAmt - (SeieAmt + SpouseSeieAmt)
    @RAddSEIEAmt.operation = "
    RSEIEPossAmt = WebCalc.find_by_name('RSEIEPossAmt')
    RSEIEPossAmt = Float(RSEIEPossAmt.calculate manager)
    SeieAmt = manager.get_answer_by_question_name('SeieAmt')
    SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
    RSEIEPossAmt - (SeieAmt.to_f + SpouseSeieAmt.to_f)
    "
    @RAddSEIEAmt.save!
    
    @delete =  WebCalc.find_by_name('REarnMinusSeieAmt')
    @delete.delete unless @delete.blank?
    @REarnMinusSeieAmt = WebCalc.new(:name => 'REarnMinusSeieAmt')
    #242 =F237-F238 REarnMinusSeieAmt = SsiOrCaidEarnAmt - SeieAmt
    @REarnMinusSeieAmt.operation = "
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    SeieAmt = manager.get_answer_by_question_name('SeieAmt')
    SsiOrCaidEarnAmt.to_f - SeieAmt.to_f
    "
    @REarnMinusSeieAmt.save!
    
    @delete =  WebCalc.find_by_name('RSpouseEarnMinusSeieAmt')
    @delete.delete unless @delete.blank?
    @RSpouseEarnMinusSeieAmt = WebCalc.new(:name => 'RSpouseEarnMinusSeieAmt')
    #244 =(F239+F240)-F241 RSpouseEarnMinusSeieAmt = (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) - SpouseSeieAmt
    @RSpouseEarnMinusSeieAmt.operation = "
    SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt')
    SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
    SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
    (SsiSpouseDeemEarnAmt.to_f + SpouseSsiOrCaidEarnAmt.to_f) - SpouseSeieAmt.to_f    
    "
    @RSpouseEarnMinusSeieAmt.save!
    
    @delete =  WebCalc.find_by_name('RIncAvailForPassNoPassAmt')
    @delete.delete unless @delete.blank?
    @RIncAvailForPassNoPassAmt = WebCalc.new(:name => 'RIncAvailForPassNoPassAmt')
    #264 =MAX(0;SUM(F248:F257)-SUM(F258:F261)) RIncAvailForPassNoPassAmt = (Sum of R_SsdiPayAllAdjustButCareBAmt thru SsiParDeemAmt) - (Sum of SsiCaidIrweAmt thru SpouseBweAmt) Not < 0
    #f248 R_SsdiPayAllAdjustButCareBAmt
    #f249 R_SpouseSsdiPayAllAdjustButCareBAmt
    #f250 UnearnAmt
    #f251 SpouseUnEarnAmt
    #f252 SsiOrCaidEarnAmt
    #f253 SpouseSsiOrCaidEarnAmt
    #f254 InKindPMVAmt
    #f255 SsiSpouseDeemUnearnAmt
    #f256 SsiSpouseDeemEarnAmt
    #f257 SsiParDeemAmt
    
    #f258 SsiCaidIrweAmt
    #f259 BweAmt
    #f260 SpouseSsiCaidIrweAmt
    #f261 SpouseBweAmt
    #f262 PassAmt {not used in this calc}
    #f263 SpousePassAmt {not used in this calc}
    @RIncAvailForPassNoPassAmt.operation = "
    R_SsdiPayAllAdjustButCareBAmt = WebCalc.find_by_name('R_SsdiPayAllAdjustButCareBAmt')
    R_SsdiPayAllAdjustButCareBAmt = Float(R_SsdiPayAllAdjustButCareBAmt.calculate manager)
    R_SpouseSsdiPayAllAdjustButCareBAmt = WebCalc.find_by_name('R_SpouseSsdiPayAllAdjustButCareBAmt')
    R_SpouseSsdiPayAllAdjustButCareBAmt = Float(R_SpouseSsdiPayAllAdjustButCareBAmt.calculate manager)
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    UnearnAmt  = manager.get_answer_by_question_name('UnearnAmt')
    SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt')
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
    InKindPMVAmt = manager.get_answer_by_question_name('InKindPMVAmt')
    SsiSpouseDeemUnearnAmt = manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt')
    SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt')
    SsiParDeemAmt = manager.get_answer_by_question_name('SsiParDeemAmt')
    SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
    BweAmt = WebCalc.find_by_name('BweAmt')
    SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
    SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
    returnVar = 0.0
    returnVar = R_SsdiPayAllAdjustButCareBAmt + R_SpouseSsdiPayAllAdjustButCareBAmt + UnearnAmt.to_f + SpouseUnEarnAmt.to_f + SsiOrCaidEarnAmt.to_f + SpouseSsiOrCaidEarnAmt.to_f + InKindPMVAmt.to_f + SsiSpouseDeemUnearnAmt.to_f + SsiSpouseDeemEarnAmt.to_f + SsiParDeemAmt.to_f
    returnVar = [(returnVar -  SsiCaidIrweAmt.to_f + BweAmt.to_f + SpouseSsiCaidIrweAmt.to_f + SpouseBweAmt.to_f), 0].min
    "
    @RIncAvailForPassNoPassAmt.save!
    
    @delete =  WebCalc.find_by_name('RIncAvailForPassMinusSpousePassAmt')
    @delete.delete unless @delete.blank?
    @RIncAvailForPassMinusSpousePassAmt = WebCalc.new(:name => 'RIncAvailForPassMinusSpousePassAmt')
    #266 =MAX(F265-F263;0) RIncAvailForPassMinusSpousePassAmt = RIncAvailForPassNoPassAmt - SpousePassAmt
    @RIncAvailForPassMinusSpousePassAmt.operation = "
    RIncAvailForPassNoPassAmt = WebCalc.find_by_name('RIncAvailForPassNoPassAmt')
    RIncAvailForPassNoPassAmt = Float(RIncAvailForPassNoPassAmt.calculate manager)
    SpousePassAmt  = manager.get_answer_by_question_name('SpousePassAmt')
    [(RIncAvailForPassNoPassAmt - SpousePassAmt.to_f), 0].max
    "
    @RIncAvailForPassMinusSpousePassAmt.save!
    
    @delete =  WebCalc.find_by_name('RIncomeAvailforSpousePassMinusUserPassAmt')
    @delete.delete unless @delete.blank?
    @RIncomeAvailforSpousePassMinusUserPassAmt = WebCalc.new(:name => 'RIncomeAvailforSpousePassMinusUserPassAmt')
    #268 =MAX(F267-F262;0) Amount of Income available for use in a Spouse's PASS if there is a user PASS (can not be less than zero)
    #f267 RIncAvailForPassMinusSpousePassAmt
    #f262 PassAmt
    @RIncomeAvailforSpousePassMinusUserPassAmt.operation = "
    RIncAvailForPassMinusSpousePassAmt = WebCalc.find_by_name('RIncAvailForPassMinusSpousePassAmt')
    RIncAvailForPassMinusSpousePassAmt = Float(RIncAvailForPassMinusSpousePassAmt.calculate manager)
    PassAmt  = manager.get_answer_by_question_name('PassAmt')
    [(RIncAvailForPassMinusSpousePassAmt - PassAmt.to_f), 0].max
    "
    @RIncomeAvailforSpousePassMinusUserPassAmt.save!
    
    @delete =  WebCalc.find_by_name('RDacNotCaidEligUnearnWithDi')
    @delete.delete unless @delete.blank?
    @RDacNotCaidEligUnearnWithDi = WebCalc.new(:name => 'RDacNotCaidEligUnearnWithDi')
    #280 =IF(AND(F272="YES";F274="YES";F276=0;F277=0;F278>0;F281=0;F282=0);1;0) IF (SsiGet = YES or SpouseSsiGet = YES) AND (SsdiDac = YES OR SpouseSsdiDac = YES) AND RSsiUnearnEligAddedPassNeedAmt > 0, THEN RDacNotCaidEligUnearnWithDi = TRUE, ELSE FALSE
    @RDacNotCaidEligUnearnWithDi.operation = "
    SsiGet  = manager.get_answer_by_question_name('SsiGet')
    SpouseSsiGet  = manager.get_answer_by_question_name('SpouseSsiGet')
    SsdiDac  = manager.get_answer_by_question_name('SsdiDac')
    SpouseSsdiDac  = WebCalc.find_by_name('SpouseSsdiDac')
    RSsiUnearnEligAddedPassNeedAmt = WebCalc.find_by_name('RSsiUnearnEligAddedPassNeedAmt')
    RSsiUnearnEligAddedPassNeedAmt = Float(RSsiUnearnEligAddedPassNeedAmt.calculate manager)
    if (SsiGet == 'Yes' || SpouseSsiGet == 'Yes') && (SsdiDac == 'Yes' || SpouseSsdiDac == 'Yes') && (RSsiUnearnEligAddedPassNeedAmt > 0) then
      true
    else
      false
    end
    "
    @RDacNotCaidEligUnearnWithDi.save!
    
    @delete =  WebCalc.find_by_name('RDacDiSubractAmt')
    @delete.delete unless @delete.blank?
    @RDacDiSubractAmt = WebCalc.new(:name => 'RDacDiSubractAmt')
    #282 =IF(F274="YES";F279;0)+IF(F275="YES";F280;0) RDacDiSubractAmt = (If SsdiDac = YES, THEN R_SsdiPayAllAdjustButCareBAmt, ELSE 0) + (If SpouseSsdiDac = YES, THEN R_SpouseSsdiPayAllAdjustButCareBAmt ELSE 0)
    @RDacDiSubractAmt.operation = "
    SsdiDac  = manager.get_answer_by_question_name('SsdiDac')
    R_SsdiPayAllAdjustButCareBAmt = WebCalc.find_by_name('R_SsdiPayAllAdjustButCareBAmt')
    R_SsdiPayAllAdjustButCareBAmt = Float(R_SsdiPayAllAdjustButCareBAmt.calculate manager)
    SpouseSsdiDac  = manager.get_answer_by_question_name('SpouseSsdiDac')
    R_SpouseSsdiPayAllAdjustButCareBAmt = WebCalc.find_by_name('R_SpouseSsdiPayAllAdjustButCareBAmt')
    R_SpouseSsdiPayAllAdjustButCareBAmt = Float(R_SpouseSsdiPayAllAdjustButCareBAmt.calculate manager)
    returnVal = 0
    if SsdiDac == 'Yes' then
      returnVal = R_SsdiPayAllAdjustButCareBAmt
    end
    if SpouseSsdiDac == 'Yes' then
      returnVal = returnVal + R_SpouseSsdiPayAllAdjustButCareBAmt
    end
    returnVal
    "
    @RDacDiSubractAmt.save!
    
    @delete =  WebCalc.find_by_name('RDacCaidIneligUnearnNoDi')
    @delete.delete unless @delete.blank?
    @RDacCaidIneligUnearnNoDi = WebCalc.new(:name => 'RDacCaidIneligUnearnNoDi')
    #284 =IF(AND(F272="YES";F274="YES";(F278-F287)>0);1;0) IF SsiGet = YES AND SsdiDac = YES AND (RSsiUnearnEligAddedPassNeedAmt - RDacDiSubractAmt) > 0, THEN RDacCaidIneligUnearnNoDi = TRUE, ELSE FALSE
    @RDacCaidIneligUnearnNoDi.operation = "
    SsiGet  = manager.get_answer_by_question_name('SsiGet')
    SsdiDac  = manager.get_answer_by_question_name('SsdiDac')
    RSsiUnearnEligAddedPassNeedAmt = WebCalc.find_by_name('RSsiUnearnEligAddedPassNeedAmt')
    RSsiUnearnEligAddedPassNeedAmt = Float(RSsiUnearnEligAddedPassNeedAmt.calculate manager)
    RDacDiSubractAmt = WebCalc.find_by_name('RDacDiSubractAmt')
    RDacDiSubractAmt = Float(RDacDiSubractAmt.calculate manager)
    if SsiGet == 'Yes' && SsdiDac == 'Yes' && ((RSsiUnearnEligAddedPassNeedAmt - RDacDiSubractAmt) > 0) then
      true
    else
      false
    end 
    "
    @RDacCaidIneligUnearnNoDi.save!
    
    @delete =  WebCalc.find_by_name('RSpouseDacCaidIneligUnearnNoDi')
    @delete.delete unless @delete.blank?
    @RSpouseDacCaidIneligUnearnNoDi = WebCalc.new(:name => 'RSpouseDacCaidIneligUnearnNoDi')
    #286 =IF(AND(F273="YES";F275="YES";(F278-F287)>0);1;0) IF SpouseSsiGet = YES AND SpouseSsdiDac = YES AND (RSsiUnearnEligAddedPassNeedAmt - RDacDiSubractAmt) > 0, THEN RSpouseDacCaidIneligUnearnNoDi = TRUE, ELSE FALSE
    
    @RSpouseDacCaidIneligUnearnNoDi.operation = "
    SpouseSsiGet  = manager.get_answer_by_question_name('SpouseSsiGet')
    SpouseSsdiDac  = manager.get_answer_by_question_name('SpouseSsdiDac')
    RSsiUnearnEligAddedPassNeedAmt = WebCalc.find_by_name('RSsiUnearnEligAddedPassNeedAmt')
    RSsiUnearnEligAddedPassNeedAmt = Float(RSsiUnearnEligAddedPassNeedAmt.calculate manager)
    RDacDiSubractAmt = WebCalc.find_by_name('RDacDiSubractAmt')
    RDacDiSubractAmt = Float(RDacDiSubractAmt.calculate manager)
    if SpouseSsiGet == 'Yes' && SpouseSsdiDac == 'Yes' && ((RSsiUnearnEligAddedPassNeedAmt - RDacDiSubractAmt) > 0) then
      true
    else
     false
   end
   "
    @RSpouseDacCaidIneligUnearnNoDi.save!
    
   #stopping here due to forthcoming WebSsiWiCalc sheet updates     
  #  x = WebCalc.new(:name => 'x')
  #  #
  #  @x.operation = "
  #  
  #  "
  #  @x.save!
    
    
  end

  def self.down
  end
end
