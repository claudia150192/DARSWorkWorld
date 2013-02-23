class AddWebSsiWiCalcCalcsToNumericResultsView < ActiveRecord::Migration
  def self.up
        
     require 'wwweb_session_manager'
   
    @BobWebSsiWiCalcSheetDisplay = WebNumericalResultsGroup.find_by_name('Testing WebSsiWiCalc variables') 
    @BobWebSsiWiCalcSheetDisplay.delete unless @BobWebSsiWiCalcSheetDisplay.blank?
    @BobWebSsiWiCalcSheetDisplay = WebNumericalResultsGroup.create!(:name => 'Testing WebSsiWiCalc variables', :order => 150)
    
    @RTotalWorkExpAmtId = WebCalc.find_by_name('RTotalWorkExpAmt') 
    @RTotalWorkExpAmt = WebNumericalResult.find_by_name('RTotalWorkExpAmt') 
    @RTotalWorkExpAmt.delete unless @RTotalWorkExpAmt.blank?
    @RTotalWorkExpAmt = WebNumericalResult.create!(:name => 'RTotalWorkExpAmt', :text => 'RTotalWorkExpAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 1, :web_calc_id => @RTotalWorkExpAmtId.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
    
    @RWorkExpAndInvestAmtId = WebCalc.find_by_name('RWorkExpAndInvestAmt') 
    @RWorkExpAndInvestAmt = WebNumericalResult.find_by_name('RWorkExpAndInvestAmt') 
    @RWorkExpAndInvestAmt.delete unless @RWorkExpAndInvestAmt.blank?
    @RWorkExpAndInvestAmt = WebNumericalResult.create!(:name => 'RWorkExpAndInvestAmt', :text => 'RWorkExpAndInvestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 2, :web_calc_id => @RWorkExpAndInvestAmtId.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
    
    @RInvestWorkExpNotPassIrweBweAmtId = WebCalc.find_by_name('RInvestWorkExpNotPassIrweBweAmt') 
    @RInvestWorkExpNotPassIrweBweAmt = WebNumericalResult.find_by_name('RInvestWorkExpNotPassIrweBweAmt') 
    @RInvestWorkExpNotPassIrweBweAmt.delete unless @RInvestWorkExpNotPassIrweBweAmt.blank?
    @RInvestWorkExpNotPassIrweBweAmt = WebNumericalResult.create!(:name => 'RInvestWorkExpNotPassIrweBweAmt', :text => 'RInvestWorkExpNotPassIrweBweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 3, :web_calc_id => @RInvestWorkExpNotPassIrweBweAmtId.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
    
     @RSpouseTotalWorkExpAmtId = WebCalc.find_by_name('RSpouseTotalWorkExpAmt') 
      @RSpouseTotalWorkExpAmt = WebNumericalResult.find_by_name('RSpouseTotalWorkExpAmt') 
      @RSpouseTotalWorkExpAmt.delete unless @RSpouseTotalWorkExpAmt.blank?
      @RSpouseTotalWorkExpAmt = WebNumericalResult.create!(:name => 'RSpouseTotalWorkExpAmt', :text => 'RSpouseTotalWorkExpAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 4, :web_calc_id => @RSpouseTotalWorkExpAmtId.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
      
      @RSpouseWorkExpAndInvestAmtId = WebCalc.find_by_name('RSpouseWorkExpAndInvestAmt') 
       @RSpouseWorkExpAndInvestAmt = WebNumericalResult.find_by_name('RSpouseWorkExpAndInvestAmt') 
       @RSpouseWorkExpAndInvestAmt.delete unless @RSpouseWorkExpAndInvestAmt.blank?
       @RSpouseWorkExpAndInvestAmt = WebNumericalResult.create!(:name => 'RSpouseWorkExpAndInvestAmt', :text => 'RSpouseWorkExpAndInvestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 5, :web_calc_id => @RSpouseWorkExpAndInvestAmtId.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

       @Id = WebCalc.find_by_name('RSpouseInvestWorkExpNotPassIrweBweAmt') 
        @RSpouseInvestWorkExpNotPassIrweBweAmt = WebNumericalResult.find_by_name('RSpouseInvestWorkExpNotPassIrweBweAmt') 
        @RSpouseInvestWorkExpNotPassIrweBweAmt.delete unless @RSpouseInvestWorkExpNotPassIrweBweAmt.blank?
        @RSpouseInvestWorkExpNotPassIrweBweAmt = WebNumericalResult.create!(:name => 'RSpouseInvestWorkExpNotPassIrweBweAmt', :text => 'RSpouseInvestWorkExpNotPassIrweBweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 6, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
      
      
    @Id = WebCalc.find_by_name('RFbrWorkIncentivePossAmt') 
     @RFbrWorkIncentivePossAmt = WebNumericalResult.find_by_name('RFbrWorkIncentivePossAmt') 
     @RFbrWorkIncentivePossAmt.delete unless @RFbrWorkIncentivePossAmt.blank?
     @RFbrWorkIncentivePossAmt = WebNumericalResult.create!(:name => 'RFbrWorkIncentivePossAmt', :text => 'RFbrWorkIncentivePossAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 7, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


     @Id = WebCalc.find_by_name('CountIncForHighestUserPassReimbAmt') 
      @CountIncForHighestUserPassReimbAmt = WebNumericalResult.find_by_name('CountIncForHighestUserPassReimbAmt') 
      @CountIncForHighestUserPassReimbAmt.delete unless @CountIncForHighestUserPassReimbAmt.blank?
      @CountIncForHighestUserPassReimbAmt = WebNumericalResult.create!(:name => 'CountIncForHighestUserPassReimbAmt', :text => 'CountIncForHighestUserPassReimbAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 8, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
 
      @Id = WebCalc.find_by_name('RCountIncForHighestSpousePassReimbAmt') 
       @RCountIncForHighestSpousePassReimbAmt = WebNumericalResult.find_by_name('RCountIncForHighestSpousePassReimbAmt') 
       @RCountIncForHighestSpousePassReimbAmt.delete unless @RCountIncForHighestSpousePassReimbAmt.blank?
       @RCountIncForHighestSpousePassReimbAmt = WebNumericalResult.create!(:name => 'RCountIncForHighestSpousePassReimbAmt', :text => 'RCountIncForHighestSpousePassReimbAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 9, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
  
  
  @Id = WebCalc.find_by_name('RHighestUserPassReimbAvailAmt') 
   @RHighestUserPassReimbAvailAmt = WebNumericalResult.find_by_name('RHighestUserPassReimbAvailAmt') 
   @RHighestUserPassReimbAvailAmt.delete unless @RHighestUserPassReimbAvailAmt.blank?
   @RHighestUserPassReimbAvailAmt = WebNumericalResult.create!(:name => 'RHighestUserPassReimbAvailAmt', :text => 'RHighestUserPassReimbAvailAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
   RShowWorkVar = (RShowWorkVar.calculate manager)
   if RShowWorkVar then
     true
   else
    false
   end", 
   :order => 10, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
 
   @Id = WebCalc.find_by_name('RHighestSpousePassReimbAvailAmt') 
    @RHighestSpousePassReimbAvailAmt = WebNumericalResult.find_by_name('RHighestSpousePassReimbAvailAmt') 
    @RHighestSpousePassReimbAvailAmt.delete unless @RHighestSpousePassReimbAvailAmt.blank?
    @RHighestSpousePassReimbAvailAmt = WebNumericalResult.create!(:name => 'RHighestSpousePassReimbAvailAmt', :text => 'RHighestSpousePassReimbAvailAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 11, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


    @Id = WebCalc.find_by_name('RUnearnForSsiCalcAmt') 
     @RUnearnForSsiCalcAmt = WebNumericalResult.find_by_name('RUnearnForSsiCalcAmt') 
     @RUnearnForSsiCalcAmt.delete unless @RUnearnForSsiCalcAmt.blank?
     @RUnearnForSsiCalcAmt = WebNumericalResult.create!(:name => 'RUnearnForSsiCalcAmt', :text => 'RUnearnForSsiCalcAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 12, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

     @Id = WebCalc.find_by_name('RFbrAmt') 
      @RFbrAmt = WebNumericalResult.find_by_name('RFbrAmt') 
      @RFbrAmt.delete unless @RFbrAmt.blank?
      @RFbrAmt = WebNumericalResult.create!(:name => 'RFbrAmt', :text => 'RFbrAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 13, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

      @Id = WebCalc.find_by_name('RUnearnMinusFbrAmt') 
       @RUnearnMinusFbrAmt = WebNumericalResult.find_by_name('RUnearnMinusFbrAmt') 
       @RUnearnMinusFbrAmt.delete unless @RUnearnMinusFbrAmt.blank?
       @RUnearnMinusFbrAmt = WebNumericalResult.create!(:name => 'RUnearnMinusFbrAmt', :text => 'RUnearnMinusFbrAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 14, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

       @Id = WebCalc.find_by_name('RSsiUnearnEligTotPassNeedAmt') 
        @RSsiUnearnEligTotPassNeedAmt = WebNumericalResult.find_by_name('RSsiUnearnEligTotPassNeedAmt') 
        @RSsiUnearnEligTotPassNeedAmt.delete unless @RSsiUnearnEligTotPassNeedAmt.blank?
        @RSsiUnearnEligTotPassNeedAmt = WebNumericalResult.create!(:name => 'RSsiUnearnEligTotPassNeedAmt', :text => 'RSsiUnearnEligTotPassNeedAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 15, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


    @Id = WebCalc.find_by_name('RSsiUnearnEligAddedPassNeedAmt') 
     @RSsiUnearnEligAddedPassNeedAmt = WebNumericalResult.find_by_name('RSsiUnearnEligAddedPassNeedAmt') 
     @RSsiUnearnEligAddedPassNeedAmt.delete unless @RSsiUnearnEligAddedPassNeedAmt.blank?
     @RSsiUnearnEligAddedPassNeedAmt = WebNumericalResult.create!(:name => 'RSsiUnearnEligAddedPassNeedAmt', :text => 'RSsiUnearnEligAddedPassNeedAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 16, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

     @Id = WebCalc.find_by_name('REarnNoIrweNoDivideAmt') 
      @REarnNoIrweNoDivideAmt = WebNumericalResult.find_by_name('REarnNoIrweNoDivideAmt') 
      @REarnNoIrweNoDivideAmt.delete unless @REarnNoIrweNoDivideAmt.blank?
      @REarnNoIrweNoDivideAmt = WebNumericalResult.create!(:name => 'REarnNoIrweNoDivideAmt', :text => 'REarnNoIrweNoDivideAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 17, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

      @Id = WebCalc.find_by_name('REarnMinusSpouseIrweNoDivideAmt') 
       @REarnMinusSpouseIrweNoDivideAmt = WebNumericalResult.find_by_name('REarnMinusSpouseIrweNoDivideAmt') 
       @REarnMinusSpouseIrweNoDivideAmt.delete unless @REarnMinusSpouseIrweNoDivideAmt.blank?
       @REarnMinusSpouseIrweNoDivideAmt = WebNumericalResult.create!(:name => 'REarnMinusSpouseIrweNoDivideAmt', :text => 'REarnMinusSpouseIrweNoDivideAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 18, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

       @Id = WebCalc.find_by_name('RCountEarnMinusSpouseIrweDivideNoBweAmt') 
        @RCountEarnMinusSpouseIrweDivideNoBweAmt = WebNumericalResult.find_by_name('RCountEarnMinusSpouseIrweDivideNoBweAmt') 
        @RCountEarnMinusSpouseIrweDivideNoBweAmt.delete unless @RCountEarnMinusSpouseIrweDivideNoBweAmt.blank?
        @RCountEarnMinusSpouseIrweDivideNoBweAmt = WebNumericalResult.create!(:name => 'RCountEarnMinusSpouseIrweDivideNoBweAmt', :text => 'RCountEarnMinusSpouseIrweDivideNoBweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 19, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

        @Id = WebCalc.find_by_name('REarnMinusSpouseIrweBweAmt') 
         @REarnMinusSpouseIrweBweAmt = WebNumericalResult.find_by_name('REarnMinusSpouseIrweBweAmt') 
         @REarnMinusSpouseIrweBweAmt.delete unless @REarnMinusSpouseIrweBweAmt.blank?
         @REarnMinusSpouseIrweBweAmt = WebNumericalResult.create!(:name => 'REarnMinusSpouseIrweBweAmt', :text => 'REarnMinusSpouseIrweBweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 20, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

         @Id = WebCalc.find_by_name('REarnMinusUserIrweNoDivideAmt') 
          @REarnMinusUserIrweNoDivideAmt = WebNumericalResult.find_by_name('REarnMinusUserIrweNoDivideAmt') 
          @REarnMinusUserIrweNoDivideAmt.delete unless @REarnMinusUserIrweNoDivideAmt.blank?
          @REarnMinusUserIrweNoDivideAmt = WebNumericalResult.create!(:name => 'REarnMinusUserIrweNoDivideAmt', :text => 'REarnMinusUserIrweNoDivideAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
          RShowWorkVar = (RShowWorkVar.calculate manager)
          if RShowWorkVar then
            true
          else
           false
          end", 
          :order => 21, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


   @Id = WebCalc.find_by_name('REarnMinusUserIrweDivideNoBweAmt') 
    @REarnMinusUserIrweDivideNoBweAmt = WebNumericalResult.find_by_name('REarnMinusUserIrweDivideNoBweAmt') 
    @REarnMinusUserIrweDivideNoBweAmt.delete unless @REarnMinusUserIrweDivideNoBweAmt.blank?
    @REarnMinusUserIrweDivideNoBweAmt = WebNumericalResult.create!(:name => 'REarnMinusUserIrweDivideNoBweAmt', :text => 'REarnMinusUserIrweDivideNoBweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 22, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


    @Id = WebCalc.find_by_name('REarnMinusUserIrweBweAmt') 
     @REarnMinusUserIrweBweAmt = WebNumericalResult.find_by_name('REarnMinusUserIrweBweAmt') 
     @REarnMinusUserIrweBweAmt.delete unless @REarnMinusUserIrweBweAmt.blank?
     @REarnMinusUserIrweBweAmt = WebNumericalResult.create!(:name => 'REarnMinusUserIrweBweAmt', :text => 'REarnMinusUserIrweBweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 23, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

     @Id = WebCalc.find_by_name('RIrweNeededForSsiSgaTestAmt') 
      @RIrweNeededForSsiSgaTestAmt = WebNumericalResult.find_by_name('RIrweNeededForSsiSgaTestAmt') 
      @RIrweNeededForSsiSgaTestAmt.delete unless @RIrweNeededForSsiSgaTestAmt.blank?
      @RIrweNeededForSsiSgaTestAmt = WebNumericalResult.create!(:name => 'RIrweNeededForSsiSgaTestAmt', :text => 'RIrweNeededForSsiSgaTestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 24, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

      @Id = WebCalc.find_by_name('RAddedIrweNeededForSsiSgaTestAmt') 
       @RAddedIrweNeededForSsiSgaTestAmt = WebNumericalResult.find_by_name('RAddedIrweNeededForSsiSgaTestAmt') 
       @RAddedIrweNeededForSsiSgaTestAmt.delete unless @RAddedIrweNeededForSsiSgaTestAmt.blank?
       @RAddedIrweNeededForSsiSgaTestAmt = WebNumericalResult.create!(:name => 'RAddedIrweNeededForSsiSgaTestAmt', :text => 'RAddedIrweNeededForSsiSgaTestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 25, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

       @Id = WebCalc.find_by_name('RIrweSubsidyNeededForDiSgaTestAmt') 
        @RIrweSubsidyNeededForDiSgaTestAmt = WebNumericalResult.find_by_name('RIrweSubsidyNeededForDiSgaTestAmt') 
        @RIrweSubsidyNeededForDiSgaTestAmt.delete unless @RIrweSubsidyNeededForDiSgaTestAmt.blank?
        @RIrweSubsidyNeededForDiSgaTestAmt = WebNumericalResult.create!(:name => 'RIrweSubsidyNeededForDiSgaTestAmt', :text => 'RIrweSubsidyNeededForDiSgaTestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 26, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

        @Id = WebCalc.find_by_name('RAddedIrweSubsidyNeededForDiSgaTestAmt') 
         @RAddedIrweSubsidyNeededForDiSgaTestAmt = WebNumericalResult.find_by_name('RAddedIrweSubsidyNeededForDiSgaTestAmt') 
         @RAddedIrweSubsidyNeededForDiSgaTestAmt.delete unless @RAddedIrweSubsidyNeededForDiSgaTestAmt.blank?
         @RAddedIrweSubsidyNeededForDiSgaTestAmt = WebNumericalResult.create!(:name => 'RAddedIrweSubsidyNeededForDiSgaTestAmt', :text => 'RAddedIrweSubsidyNeededForDiSgaTestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 27, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)



     @Id = WebCalc.find_by_name('RSpouseIrweNeededForSsiSgaTestAmt') 
      @RSpouseIrweNeededForSsiSgaTestAmt = WebNumericalResult.find_by_name('RSpouseIrweNeededForSsiSgaTestAmt') 
      @RSpouseIrweNeededForSsiSgaTestAmt.delete unless @RSpouseIrweNeededForSsiSgaTestAmt.blank?
      @RSpouseIrweNeededForSsiSgaTestAmt = WebNumericalResult.create!(:name => 'RSpouseIrweNeededForSsiSgaTestAmt', :text => 'RSpouseIrweNeededForSsiSgaTestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 28, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

      @Id = WebCalc.find_by_name('RSpouseAddedIrweNeededForSsiSgaTestAmt') 
       @RSpouseAddedIrweNeededForSsiSgaTestAmt = WebNumericalResult.find_by_name('RSpouseAddedIrweNeededForSsiSgaTestAmt') 
       @RSpouseAddedIrweNeededForSsiSgaTestAmt.delete unless @RSpouseAddedIrweNeededForSsiSgaTestAmt.blank?
       @RSpouseAddedIrweNeededForSsiSgaTestAmt = WebNumericalResult.create!(:name => 'RSpouseAddedIrweNeededForSsiSgaTestAmt', :text => 'RSpouseAddedIrweNeededForSsiSgaTestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 29, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

       @Id = WebCalc.find_by_name('RSpouseIrweSubsidyNeededForDiSgaTestAmt') 
        @RSpouseIrweSubsidyNeededForDiSgaTestAmt = WebNumericalResult.find_by_name('RSpouseIrweSubsidyNeededForDiSgaTestAmt') 
        @RSpouseIrweSubsidyNeededForDiSgaTestAmt.delete unless @RSpouseIrweSubsidyNeededForDiSgaTestAmt.blank?
        @RSpouseIrweSubsidyNeededForDiSgaTestAmt = WebNumericalResult.create!(:name => 'RSpouseIrweSubsidyNeededForDiSgaTestAmt', :text => 'RSpouseIrweSubsidyNeededForDiSgaTestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 30, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

        @Id = WebCalc.find_by_name('RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt') 
         @RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt = WebNumericalResult.find_by_name('RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt') 
         @RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt.delete unless @RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt.blank?
         @RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt = WebNumericalResult.create!(:name => 'RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt', :text => 'RSpouseAddedIrweSubsidyNeededForDiSgaTestAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 31, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

         @Id = WebCalc.find_by_name('RDisWorkExpNotIrwePassAmt') 
          @RDisWorkExpNotIrwePassAmt = WebNumericalResult.find_by_name('RDisWorkExpNotIrwePassAmt') 
          @RDisWorkExpNotIrwePassAmt.delete unless @RDisWorkExpNotIrwePassAmt.blank?
          @RDisWorkExpNotIrwePassAmt = WebNumericalResult.create!(:name => 'RDisWorkExpNotIrwePassAmt', :text => 'RDisWorkExpNotIrwePassAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
          RShowWorkVar = (RShowWorkVar.calculate manager)
          if RShowWorkVar then
            true
          else
           false
          end", 
          :order => 32, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


      @Id = WebCalc.find_by_name('RSpouseDisWorkExpNotIrwePassAmt') 
       @RSpouseDisWorkExpNotIrwePassAmt = WebNumericalResult.find_by_name('RSpouseDisWorkExpNotIrwePassAmt') 
       @RSpouseDisWorkExpNotIrwePassAmt.delete unless @RSpouseDisWorkExpNotIrwePassAmt.blank?
       @RSpouseDisWorkExpNotIrwePassAmt = WebNumericalResult.create!(:name => 'RSpouseDisWorkExpNotIrwePassAmt', :text => 'RSpouseDisWorkExpNotIrwePassAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 33, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

       @Id = WebCalc.find_by_name('R_UnearnForSsiCalcAmt') 
        @R_UnearnForSsiCalcAmt = WebNumericalResult.find_by_name('R_UnearnForSsiCalcAmt') 
        @R_UnearnForSsiCalcAmt.delete unless @R_UnearnForSsiCalcAmt.blank?
        @R_UnearnForSsiCalcAmt = WebNumericalResult.create!(:name => 'R_UnearnForSsiCalcAmt', :text => 'R_UnearnForSsiCalcAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 34, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

        @Id = WebCalc.find_by_name('RMaxSsiCheckWithIrweBweAmt') 
         @RMaxSsiCheckWithIrweBweAmt = WebNumericalResult.find_by_name('RMaxSsiCheckWithIrweBweAmt') 
         @RMaxSsiCheckWithIrweBweAmt.delete unless @RMaxSsiCheckWithIrweBweAmt.blank?
         @RMaxSsiCheckWithIrweBweAmt = WebNumericalResult.create!(:name => 'RMaxSsiCheckWithIrweBweAmt', :text => 'RMaxSsiCheckWithIrweBweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 35, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

         @Id = WebCalc.find_by_name('RMaxReimbPossWithIrweAmt') 
          @RMaxReimbPossWithIrweAmt = WebNumericalResult.find_by_name('RMaxReimbPossWithIrweAmt') 
          @RMaxReimbPossWithIrweAmt.delete unless @RMaxReimbPossWithIrweAmt.blank?
          @RMaxReimbPossWithIrweAmt = WebNumericalResult.create!(:name => 'RMaxReimbPossWithIrweAmt', :text => 'RMaxReimbPossWithIrweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
          RShowWorkVar = (RShowWorkVar.calculate manager)
          if RShowWorkVar then
            true
          else
           false
          end", 
          :order => 36, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

    @Id = WebCalc.find_by_name('RIrweForMaxReimbPossAmt') 
     @RIrweForMaxReimbPossAmt = WebNumericalResult.find_by_name('RIrweForMaxReimbPossAmt') 
     @RIrweForMaxReimbPossAmt.delete unless @RIrweForMaxReimbPossAmt.blank?
     @RIrweForMaxReimbPossAmt = WebNumericalResult.create!(:name => 'RIrweForMaxReimbPossAmt', :text => 'RIrweForMaxReimbPossAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 37, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


     @Id = WebCalc.find_by_name('RSpouseMaxReimbPossWithIrweAmt') 
      @RSpouseMaxReimbPossWithIrweAmt = WebNumericalResult.find_by_name('RSpouseMaxReimbPossWithIrweAmt') 
      @RSpouseMaxReimbPossWithIrweAmt.delete unless @RSpouseMaxReimbPossWithIrweAmt.blank?
      @RSpouseMaxReimbPossWithIrweAmt = WebNumericalResult.create!(:name => 'RSpouseMaxReimbPossWithIrweAmt', :text => 'RSpouseMaxReimbPossWithIrweAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 38, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)


      @Id = WebCalc.find_by_name('RIrweForMaxReimbPossAmt') 
       @RIrweForMaxReimbPossAmt = WebNumericalResult.find_by_name('RIrweForMaxReimbPossAmt') 
       @RIrweForMaxReimbPossAmt.delete unless @RIrweForMaxReimbPossAmt.blank?
       @RIrweForMaxReimbPossAmt = WebNumericalResult.create!(:name => 'RIrweForMaxReimbPossAmt', :text => 'RIrweForMaxReimbPossAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 39, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

       @Id = WebCalc.find_by_name('RTotWorkExpAmt') 
        @RTotWorkExpAmt = WebNumericalResult.find_by_name('RTotWorkExpAmt') 
        @RTotWorkExpAmt.delete unless @RTotWorkExpAmt.blank?
        @RTotWorkExpAmt = WebNumericalResult.create!(:name => 'RTotWorkExpAmt', :text => 'RTotWorkExpAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 40, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

        @Id = WebCalc.find_by_name('RWorkExpNotBweOrPassAmt') 
         @RWorkExpNotBweOrPassAmt = WebNumericalResult.find_by_name('RWorkExpNotBweOrPassAmt') 
         @RWorkExpNotBweOrPassAmt.delete unless @RWorkExpNotBweOrPassAmt.blank?
         @RWorkExpNotBweOrPassAmt = WebNumericalResult.create!(:name => 'RWorkExpNotBweOrPassAmt', :text => 'RWorkExpNotBweOrPassAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 41, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

     @Id = WebCalc.find_by_name('RSpouseTotWorkExpAmt') 
      @RSpouseTotWorkExpAmt = WebNumericalResult.find_by_name('RSpouseTotWorkExpAmt') 
      @RSpouseTotWorkExpAmt.delete unless @RSpouseTotWorkExpAmt.blank?
      @RSpouseTotWorkExpAmt = WebNumericalResult.create!(:name => 'RSpouseTotWorkExpAmt', :text => 'RSpouseTotWorkExpAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 42, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

      @Id = WebCalc.find_by_name('RSpouseWorkExpNotBweOrPassAmt') 
       @RSpouseWorkExpNotBweOrPassAmt = WebNumericalResult.find_by_name('RSpouseWorkExpNotBweOrPassAmt') 
       @RSpouseWorkExpNotBweOrPassAmt.delete unless @RSpouseWorkExpNotBweOrPassAmt.blank?
       @RSpouseWorkExpNotBweOrPassAmt = WebNumericalResult.create!(:name => 'RSpouseWorkExpNotBweOrPassAmt', :text => 'RSpouseWorkExpNotBweOrPassAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 43, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

       @Id = WebCalc.find_by_name('RTotBweReimbAvail') 
         @RTotBweReimbAvail = WebNumericalResult.find_by_name('RTotBweReimbAvail') 
         @RTotBweReimbAvail.delete unless @RTotBweReimbAvail.blank?
         @RTotBweReimbAvail = WebNumericalResult.create!(:name => 'RTotBweReimbAvail', :text => 'RTotBweReimbAvail',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 44, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

   @Id = WebCalc.find_by_name('RSpouseTotBweReimbAvail') 
     @RSpouseTotBweReimbAvail = WebNumericalResult.find_by_name('RSpouseTotBweReimbAvail') 
     @RSpouseTotBweReimbAvail.delete unless @RSpouseTotBweReimbAvail.blank?
     @RSpouseTotBweReimbAvail = WebNumericalResult.create!(:name => 'RSpouseTotBweReimbAvail', :text => 'RSpouseTotBweReimbAvail',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 45, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

     @Id = WebCalc.find_by_name('RSSIEarnSpouseEarnOrDeemAmt') 
       @RSSIEarnSpouseEarnOrDeemAmt = WebNumericalResult.find_by_name('RSSIEarnSpouseEarnOrDeemAmt') 
       @RSSIEarnSpouseEarnOrDeemAmt.delete unless @RSSIEarnSpouseEarnOrDeemAmt.blank?
       @RSSIEarnSpouseEarnOrDeemAmt = WebNumericalResult.create!(:name => 'RSSIEarnSpouseEarnOrDeemAmt', :text => 'RSSIEarnSpouseEarnOrDeemAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 46, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
     
       @Id = WebCalc.find_by_name('RSEIEPossAmt') 
         @RSEIEPossAmt = WebNumericalResult.find_by_name('RSEIEPossAmt') 
         @RSEIEPossAmt.delete unless @RSEIEPossAmt.blank?
         @RSEIEPossAmt = WebNumericalResult.create!(:name => 'RSEIEPossAmt', :text => 'RSEIEPossAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 47, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
     
     @Id = WebCalc.find_by_name('RAddSEIEAmt') 
       @RAddSEIEAmt = WebNumericalResult.find_by_name('RAddSEIEAmt') 
       @RAddSEIEAmt.delete unless @RAddSEIEAmt.blank?
       @RAddSEIEAmt = WebNumericalResult.create!(:name => 'RAddSEIEAmt', :text => 'RAddSEIEAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 48, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
     
       @Id = WebCalc.find_by_name('REarnMinusSeieAmt') 
         @REarnMinusSeieAmt = WebNumericalResult.find_by_name('REarnMinusSeieAmt') 
         @REarnMinusSeieAmt.delete unless @REarnMinusSeieAmt.blank?
         @REarnMinusSeieAmt = WebNumericalResult.create!(:name => 'REarnMinusSeieAmt', :text => 'REarnMinusSeieAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 49, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     

    @Id = WebCalc.find_by_name('RSpouseEarnMinusSeieAmt') 
      @RSpouseEarnMinusSeieAmt = WebNumericalResult.find_by_name('RSpouseEarnMinusSeieAmt') 
      @RSpouseEarnMinusSeieAmt.delete unless @RSpouseEarnMinusSeieAmt.blank?
      @RSpouseEarnMinusSeieAmt = WebNumericalResult.create!(:name => 'RSpouseEarnMinusSeieAmt', :text => 'RSpouseEarnMinusSeieAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 50, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
     
      @Id = WebCalc.find_by_name('RIncAvailForPassNoPassAmt') 
        @RIncAvailForPassNoPassAmt = WebNumericalResult.find_by_name('RIncAvailForPassNoPassAmt') 
        @RIncAvailForPassNoPassAmt.delete unless @RIncAvailForPassNoPassAmt.blank?
        @RIncAvailForPassNoPassAmt = WebNumericalResult.create!(:name => 'RIncAvailForPassNoPassAmt', :text => 'RIncAvailForPassNoPassAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 51, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
     

   @Id = WebCalc.find_by_name('RIncAvailForPassMinusSpousePassAmt') 
     @RIncAvailForPassMinusSpousePassAmt = WebNumericalResult.find_by_name('RIncAvailForPassMinusSpousePassAmt') 
     @RIncAvailForPassMinusSpousePassAmt.delete unless @RIncAvailForPassMinusSpousePassAmt.blank?
     @RIncAvailForPassMinusSpousePassAmt = WebNumericalResult.create!(:name => 'RIncAvailForPassMinusSpousePassAmt', :text => 'RIncAvailForPassMinusSpousePassAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 52, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
  
     @Id = WebCalc.find_by_name('RIncomeAvailforSpousePassMinusUserPassAmt') 
       @RIncomeAvailforSpousePassMinusUserPassAmt = WebNumericalResult.find_by_name('RIncomeAvailforSpousePassMinusUserPassAmt') 
       @RIncomeAvailforSpousePassMinusUserPassAmt.delete unless @RIncomeAvailforSpousePassMinusUserPassAmt.blank?
       @RIncomeAvailforSpousePassMinusUserPassAmt = WebNumericalResult.create!(:name => 'RIncomeAvailforSpousePassMinusUserPassAmt', :text => 'RIncomeAvailforSpousePassMinusUserPassAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 53, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
  
       @Id = WebCalc.find_by_name('RDacNotCaidEligUnearnWithDi') 
         @RDacNotCaidEligUnearnWithDi = WebNumericalResult.find_by_name('RDacNotCaidEligUnearnWithDi') 
         @RDacNotCaidEligUnearnWithDi.delete unless @RDacNotCaidEligUnearnWithDi.blank?
         @RDacNotCaidEligUnearnWithDi = WebNumericalResult.create!(:name => 'RDacNotCaidEligUnearnWithDi', :text => 'RDacNotCaidEligUnearnWithDi',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 54, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
  
    @Id = WebCalc.find_by_name('RDacDiSubractAmt') 
      @RDacDiSubractAmt = WebNumericalResult.find_by_name('RDacDiSubractAmt') 
      @RDacDiSubractAmt.delete unless @RDacDiSubractAmt.blank?
      @RDacDiSubractAmt = WebNumericalResult.create!(:name => 'RDacDiSubractAmt', :text => 'RDacDiSubractAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 55, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)     
  
      @Id = WebCalc.find_by_name('RDacCaidIneligUnearnNoDi') 
       @RDacCaidIneligUnearnNoDi = WebNumericalResult.find_by_name('RDacCaidIneligUnearnNoDi') 
       @RDacCaidIneligUnearnNoDi.delete unless @RDacCaidIneligUnearnNoDi.blank?
       @RDacCaidIneligUnearnNoDi = WebNumericalResult.create!(:name => 'RDacCaidIneligUnearnNoDi', :text => 'RDacCaidIneligUnearnNoDi',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 56, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

  @Id = WebCalc.find_by_name('RSpouseDacCaidIneligUnearnNoDi') 
   @RSpouseDacCaidIneligUnearnNoDi = WebNumericalResult.find_by_name('RSpouseDacCaidIneligUnearnNoDi') 
   @RSpouseDacCaidIneligUnearnNoDi.delete unless @RSpouseDacCaidIneligUnearnNoDi.blank?
   @RSpouseDacCaidIneligUnearnNoDi = WebNumericalResult.create!(:name => 'RSpouseDacCaidIneligUnearnNoDi', :text => 'RSpouseDacCaidIneligUnearnNoDi',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
   RShowWorkVar = (RShowWorkVar.calculate manager)
   if RShowWorkVar then
     true
   else
    false
   end", 
   :order => 57, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

#end of this batch, not all worksheet ready for input



     

























  end

  def self.down
  end
end
