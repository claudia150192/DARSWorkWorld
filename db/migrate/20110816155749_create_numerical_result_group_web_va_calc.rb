class CreateNumericalResultGroupWebVaCalc < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'
    
      @BobWebVACalcCalcSheetDisplay = WebNumericalResultsGroup.find_by_name('Testing WebVACalc variables') 
      @BobWebVACalcCalcSheetDisplay.delete unless @BobWebVACalcCalcSheetDisplay.blank?
      @BobWebVACalcCalcSheetDisplay = WebNumericalResultsGroup.create!(:name => 'Testing WebVACalc variables', :order => 200)
#AWS TODO Need to figure out why these won't run.
=begin
         @R_VA_IndivProvAuxGrantPaymentAmtId = WebCalc.find_by_name('R_VA_IndivProvAuxGrantPaymentAmt') 
         @R_VA_IndivProvAuxGrantPaymentAmt = WebNumericalResult.find_by_name('R_VA_IndivProvAuxGrantPaymentAmt') 
         @R_VA_IndivProvAuxGrantPaymentAmt.delete unless @R_VA_IndivProvAuxGrantPaymentAmt.blank?
         @R_VA_IndivProvAuxGrantPaymentAmt = WebNumericalResult.create!(:name => 'R_VA_IndivProvAuxGrantPaymentAmt', :text => 'R_VA_IndivProvAuxGrantPaymentAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 1, :web_calc_id => @R_VA_IndivProvAuxGrantPaymentAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CoupleProvAuxGrantPaymentAmtId = WebCalc.find_by_name('R_VA_CoupleProvAuxGrantPaymentAmt') 
        @R_VA_CoupleProvAuxGrantPaymentAmt = WebNumericalResult.find_by_name('R_VA_CoupleProvAuxGrantPaymentAmt') 
        @R_VA_CoupleProvAuxGrantPaymentAmt.delete unless @R_VA_CoupleProvAuxGrantPaymentAmt.blank?
        @R_VA_CoupleProvAuxGrantPaymentAmt = WebNumericalResult.create!(:name => 'R_VA_CoupleProvAuxGrantPaymentAmt', :text => 'R_VA_CoupleProvAuxGrantPaymentAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 4, :web_calc_id => @R_VA_CoupleProvAuxGrantPaymentAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_ProvAuxGrantPaymentAmtId = WebCalc.find_by_name('R_VA_ProvAuxGrantPaymentAmt') 
        @R_VA_ProvAuxGrantPaymentAmt = WebNumericalResult.find_by_name('R_VA_ProvAuxGrantPaymentAmt') 
        @R_VA_ProvAuxGrantPaymentAmt.delete unless @R_VA_ProvAuxGrantPaymentAmt.blank?
        @R_VA_ProvAuxGrantPaymentAmt = WebNumericalResult.create!(:name => 'R_VA_ProvAuxGrantPaymentAmt', :text => 'R_VA_ProvAuxGrantPaymentAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 7, :web_calc_id => @R_VA_ProvAuxGrantPaymentAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id) 

           @RTotCountIncFBRExceedAmtId = WebCalc.find_by_name('RTotCountIncFBRExceedAmt') 
           @RTotCountIncFBRExceedAmt = WebNumericalResult.find_by_name('RTotCountIncFBRExceedAmt') 
           @RTotCountIncFBRExceedAmt.delete unless @RTotCountIncFBRExceedAmt.blank?
           @RTotCountIncFBRExceedAmt = WebNumericalResult.create!(:name => 'RTotCountIncFBRExceedAmt', :text => 'RTotCountIncFBRExceedAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
           RShowWorkVar = (RShowWorkVar.calculate manager)
           if RShowWorkVar then
             true
           else
            false
           end", 
           :order => 10, :web_calc_id => @RTotCountIncFBRExceedAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id) 


         @R_VA_AuxGrantPaymentAmtId = WebCalc.find_by_name('R_VA_AuxGrantPaymentAmt') 
         @R_VA_AuxGrantPaymentAmt = WebNumericalResult.find_by_name('R_VA_AuxGrantPaymentAmt') 
         @R_VA_AuxGrantPaymentAmt.delete unless @R_VA_AuxGrantPaymentAmt.blank?
         @R_VA_AuxGrantPaymentAmt = WebNumericalResult.create!(:name => 'R_VA_AuxGrantPaymentAmt', :text => 'R_VA_AuxGrantPaymentAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 13, :web_calc_id => @R_VA_AuxGrantPaymentAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)


      @R_VA_CaidUnearnNoDeemAmtId = WebCalc.find_by_name('R_VA_CaidUnearnNoDeemAmt') 
          @R_VA_CaidUnearnNoDeemAmt = WebNumericalResult.find_by_name('R_VA_CaidUnearnNoDeemAmt') 
          @R_VA_CaidUnearnNoDeemAmt.delete unless @R_VA_CaidUnearnNoDeemAmt.blank?
          @R_VA_CaidUnearnNoDeemAmt = WebNumericalResult.create!(:name => 'R_VA_CaidUnearnNoDeemAmt', :text => 'R_VA_CaidUnearnNoDeemAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
          RShowWorkVar = (RShowWorkVar.calculate manager)
          if RShowWorkVar then
            true
          else
           false
          end", 
          :order => 17, :web_calc_id => @R_VA_CaidUnearnNoDeemAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

       @R_VA_CaidDeemedAmtId = WebCalc.find_by_name('R_VA_CaidDeemedAmt') 
       @R_VA_CaidDeemedAmt = WebNumericalResult.find_by_name('R_VA_CaidDeemedAmt') 
       @R_VA_CaidDeemedAmt.delete unless @R_VA_CaidUnearnNoDeemAmt.blank?
       @R_VA_CaidDeemedAmt = WebNumericalResult.create!(:name => 'R_VA_CaidDeemedAmt', :text => 'R_VA_CaidDeemedAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 20, :web_calc_id => @R_VA_CaidDeemedAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidUnearnAmtId = WebCalc.find_by_name('R_VA_CaidUnearnAmt') 
        @R_VA_CaidUnearnAmt = WebNumericalResult.find_by_name('R_VA_CaidUnearnAmt') 
        @R_VA_CaidUnearnAmt.delete unless @R_VA_CaidUnearnAmt.blank?
        @R_VA_CaidUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidUnearnAmt', :text => 'R_VA_CaidUnearnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 23, :web_calc_id => @R_VA_CaidUnearnAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidEarnAmtId = WebCalc.find_by_name('R_VA_CaidEarnAmt') 
        @R_VA_CaidEarnAmt = WebNumericalResult.find_by_name('R_VA_CaidEarnAmt') 
        @R_VA_CaidEarnAmt.delete unless @R_VA_CaidEarnAmt.blank?
        @R_VA_CaidEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidEarnAmt', :text => 'R_VA_CaidEarnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 27, :web_calc_id => @R_VA_CaidEarnAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidGrossIncomeAmtId = WebCalc.find_by_name('R_VA_CaidGrossIncomeAmt') 
         @R_VA_CaidGrossIncomeAmt = WebNumericalResult.find_by_name('R_VA_CaidGrossIncomeAmt') 
         @R_VA_CaidGrossIncomeAmt.delete unless @R_VA_CaidGrossIncomeAmt.blank?
         @R_VA_CaidGrossIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidGrossIncomeAmt', :text => 'R_VA_CaidGrossIncomeAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 30, :web_calc_id => @R_VA_CaidGrossIncomeAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidSpouseUnearnAmtId = WebCalc.find_by_name('R_VA_CaidSpouseUnearnAmt') 
          @R_VA_CaidSpouseUnearnAmt = WebNumericalResult.find_by_name('R_VA_CaidSpouseUnearnAmt') 
          @R_VA_CaidSpouseUnearnAmt.delete unless @R_VA_CaidSpouseUnearnAmt.blank?
          @R_VA_CaidSpouseUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseUnearnAmt', :text => 'R_VA_CaidSpouseUnearnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
          RShowWorkVar = (RShowWorkVar.calculate manager)
          if RShowWorkVar then
            true
          else
           false
          end", 
          :order => 33, :web_calc_id => @R_VA_CaidSpouseUnearnAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

          @R_VA_CaidSpouseEarnAmtId = WebCalc.find_by_name('R_VA_CaidSpouseEarnAmt') 
          @R_VA_CaidSpouseEarnAmt = WebNumericalResult.find_by_name('R_VA_CaidSpouseEarnAmt') 
          @R_VA_CaidSpouseEarnAmt.delete unless @R_VA_CaidSpouseEarnAmt.blank?
          @R_VA_CaidSpouseEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseEarnAmt', :text => 'R_VA_CaidSpouseEarnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
          RShowWorkVar = (RShowWorkVar.calculate manager)
          if RShowWorkVar then
            true
          else
           false
          end", 
          :order => 36, :web_calc_id => @R_VA_CaidSpouseEarnAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)      

          @R_VA_CaidSpouseGrossIncomeAmtId = WebCalc.find_by_name('R_VA_CaidSpouseGrossIncomeAmt') 
           @R_VA_CaidSpouseGrossIncomeAmt = WebNumericalResult.find_by_name('R_VA_CaidSpouseGrossIncomeAmt') 
           @R_VA_CaidSpouseGrossIncomeAmt.delete unless @R_VA_CaidSpouseGrossIncomeAmt.blank?
           @R_VA_CaidSpouseGrossIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseGrossIncomeAmt', :text => 'R_VA_CaidSpouseGrossIncomeAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
           RShowWorkVar = (RShowWorkVar.calculate manager)
           if RShowWorkVar then
             true
           else
            false
           end", 
           :order => 39, :web_calc_id => @R_VA_CaidSpouseGrossIncomeAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)      

         @R_VA_CaidCoupleEarnAmtId = WebCalc.find_by_name('R_VA_CaidCoupleEarnAmt') 
         @R_VA_CaidCoupleEarnAmt = WebNumericalResult.find_by_name('R_VA_CaidCoupleEarnAmt') 
         @R_VA_CaidCoupleEarnAmt.delete unless @R_VA_CaidCoupleEarnAmt.blank?
         @R_VA_CaidCoupleEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleEarnAmt', :text => 'R_VA_CaidCoupleEarnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 42, :web_calc_id => @R_VA_CaidCoupleEarnAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)      

       @R_VA_CaidCoupleUnearnAmtId = WebCalc.find_by_name('R_VA_CaidCoupleUnearnAmt') 
        @R_VA_CaidCoupleUnearnAmt = WebNumericalResult.find_by_name('R_VA_CaidCoupleUnearnAmt') 
        @R_VA_CaidCoupleUnearnAmt.delete unless @R_VA_CaidCoupleUnearnAmt.blank?
        @R_VA_CaidCoupleUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleUnearnAmt', :text => 'R_VA_CaidCoupleUnearnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 45, :web_calc_id => @R_VA_CaidCoupleUnearnAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidCoupleGrossIncomeAmtId = WebCalc.find_by_name('R_VA_CaidCoupleGrossIncomeAmt') 
         @R_VA_CaidCoupleGrossIncomeAmt = WebNumericalResult.find_by_name('R_VA_CaidCoupleGrossIncomeAmt') 
         @R_VA_CaidCoupleGrossIncomeAmt.delete unless @R_VA_CaidCoupleGrossIncomeAmt.blank?
         @R_VA_CaidCoupleGrossIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleGrossIncomeAmt', :text => 'R_VA_CaidCoupleGrossIncomeAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 48, :web_calc_id => @R_VA_CaidCoupleGrossIncomeAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

         @R_VA_CaidCountUnearnNoNeedIncomeAmtId = WebCalc.find_by_name('R_VA_CaidCountUnearnNoNeedIncomeAmt') 
          @R_VA_CaidCountUnearnNoNeedIncomeAmt = WebNumericalResult.find_by_name('R_VA_CaidCountUnearnNoNeedIncomeAmt') 
          @R_VA_CaidCountUnearnNoNeedIncomeAmt.delete unless @R_VA_CaidCountUnearnNoNeedIncomeAmt.blank?
          @R_VA_CaidCountUnearnNoNeedIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCountUnearnNoNeedIncomeAmt', :text => 'R_VA_CaidCountUnearnNoNeedIncomeAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
          RShowWorkVar = (RShowWorkVar.calculate manager)
          if RShowWorkVar then
            true
          else
           false
          end", 
          :order => 51, :web_calc_id => @R_VA_CaidCountUnearnNoNeedIncomeAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

         @R_VA_CaidCountUnearnAmtId = WebCalc.find_by_name('R_VA_CaidCountUnearnAmt') 
         @R_VA_CaidCountUnearnAmt = WebNumericalResult.find_by_name('R_VA_CaidCountUnearnAmt') 
         @R_VA_CaidCountUnearnAmt.delete unless @R_VA_CaidCountUnearnAmt.blank?
         @R_VA_CaidCountUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCountUnearnAmt', :text => 'R_VA_CaidCountUnearnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 54, :web_calc_id => @R_VA_CaidCountUnearnAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

         @R_VA_CaidExcessGenExcludeId = WebCalc.find_by_name('R_VA_CaidExcessGenExclude') 
         @R_VA_CaidExcessGenExclude = WebNumericalResult.find_by_name('R_VA_CaidExcessGenExclude') 
         @R_VA_CaidExcessGenExclude.delete unless @R_VA_CaidExcessGenExclude.blank?
         @R_VA_CaidExcessGenExclude = WebNumericalResult.create!(:name => 'R_VA_CaidExcessGenExclude', :text => 'R_VA_CaidExcessGenExclude', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 57, :web_calc_id => @R_VA_CaidExcessGenExcludeId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)

         @R_VA_CaidCountEarnAmtNoDivideId = WebCalc.find_by_name('R_VA_CaidCountEarnAmtNoDivide') 
         @R_VA_CaidCountEarnAmtNoDivide = WebNumericalResult.find_by_name('R_VA_CaidCountEarnAmtNoDivide') 
         @R_VA_CaidCountEarnAmtNoDivide.delete unless @R_VA_CaidCountEarnAmtNoDivide.blank?
         @R_VA_CaidCountEarnAmtNoDivide = WebNumericalResult.create!(:name => 'R_VA_CaidCountEarnAmtNoDivide', :text => 'R_VA_CaidCountEarnAmtNoDivide', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 60, :web_calc_id => @R_VA_CaidCountEarnAmtNoDivideId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)


         @R_VA_CaidCountEarnAmtNoBWEId = WebCalc.find_by_name('R_VA_CaidCountEarnAmtNoBWE') 
         @R_VA_CaidCountEarnAmtNoBWE = WebNumericalResult.find_by_name('R_VA_CaidCountEarnAmtNoBWE') 
         @R_VA_CaidCountEarnAmtNoBWE.delete unless @R_VA_CaidCountEarnAmtNoBWE.blank?
         @R_VA_CaidCountEarnAmtNoBWE = WebNumericalResult.create!(:name => 'R_VA_CaidCountEarnAmtNoBWE', :text => 'R_VA_CaidCountEarnAmtNoBWE', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 63, :web_calc_id => @R_VA_CaidCountEarnAmtNoBWEId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)


         @R_VA_CaidCountEarnAmtId = WebCalc.find_by_name('R_VA_CaidCountEarnAmt') 
         @R_VA_CaidCountEarnAmt = WebNumericalResult.find_by_name('R_VA_CaidCountEarnAmt') 
         @R_VA_CaidCountEarnAmt.delete unless @R_VA_CaidCountEarnAmt.blank?
         @R_VA_CaidCountEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCountEarnAmt', :text => 'R_VA_CaidCountEarnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 66, :web_calc_id => @R_VA_CaidCountEarnAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)      


         @VA_CaidCountIncomeAmtNoPASSId = WebCalc.find_by_name('VA_CaidCountIncomeAmtNoPASS') 
         @VA_CaidCountIncomeAmtNoPASS = WebNumericalResult.find_by_name('VA_CaidCountIncomeAmtNoPASS') 
         @VA_CaidCountIncomeAmtNoPASS.delete unless @VA_CaidCountIncomeAmtNoPASS.blank?
         @VA_CaidCountIncomeAmtNoPASS = WebNumericalResult.create!(:name => 'VA_CaidCountIncomeAmtNoPASS', :text => 'VA_CaidCountIncomeAmtNoPASS', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 69, :web_calc_id => @VA_CaidCountIncomeAmtNoPASSId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)      

        @R_VA_CaidCountIncomeAmtId = WebCalc.find_by_name('R_VA_CaidCountIncomeAmt') 
        @R_VA_CaidCountIncomeAmt = WebNumericalResult.find_by_name('R_VA_CaidCountIncomeAmt') 
        @R_VA_CaidCountIncomeAmt.delete unless @R_VA_CaidCountIncomeAmt.blank?
        @R_VA_CaidCountIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCountIncomeAmt', :text => 'R_VA_CaidCountIncomeAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 72, :web_calc_id => @R_VA_CaidCountIncomeAmtId.id,    :group_id => @BobWebVACalcCalcSheetDisplay.id)      

        @R_VA_CaidSpouseExcessUserGenExcludeId = WebCalc.find_by_name('R_VA_CaidSpouseExcessUserGenExclude') 
        @R_VA_CaidSpouseExcessUserGenExclude = WebNumericalResult.find_by_name('R_VA_CaidSpouseExcessUserGenExclude') 
        @R_VA_CaidSpouseExcessUserGenExclude.delete unless @R_VA_CaidSpouseExcessUserGenExclude.blank?
        @R_VA_CaidSpouseExcessUserGenExclude = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseExcessUserGenExclude', :text => 'R_VA_CaidSpouseExcessUserGenExclude', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 75, :web_calc_id => @R_VA_CaidSpouseExcessUserGenExcludeId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)      

        @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmtId = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt') 
        @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt') 
        @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt.delete unless @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt.blank?
        @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt', :text => 'R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 78, :web_calc_id => @R_VA_CaidSpouseCountUnearnNoNeedIncomeAmtId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidSpouseCountUnearnAmtId = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnAmt') 
        @R_VA_CaidSpouseCountUnearnAmt = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountUnearnAmt') 
        @R_VA_CaidSpouseCountUnearnAmt.delete unless @R_VA_CaidSpouseCountUnearnAmt.blank?
        @R_VA_CaidSpouseCountUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountUnearnAmt', :text => 'R_VA_CaidSpouseCountUnearnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 81, :web_calc_id => @R_VA_CaidSpouseCountUnearnAmtId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidSpouseUnusedGenExcludeId = WebCalc.find_by_name('R_VA_CaidSpouseUnusedGenExclude') 
        @R_VA_CaidSpouseUnusedGenExclude = WebNumericalResult.find_by_name('R_VA_CaidSpouseUnusedGenExclude') 
        @R_VA_CaidSpouseUnusedGenExclude.delete unless @R_VA_CaidSpouseUnusedGenExclude.blank?
        @R_VA_CaidSpouseUnusedGenExclude = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseUnusedGenExclude', :text => 'R_VA_CaidSpouseUnusedGenExclude', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 84, :web_calc_id => @R_VA_CaidSpouseUnusedGenExcludeId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidSpouseExcessUserEarnedIncomeDisregardId =          WebCalc.find_by_name('R_VA_CaidSpouseExcessUserEarnedIncomeDisregard') 
        @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard = WebNumericalResult.find_by_name('R_VA_CaidSpouseExcessUserEarnedIncomeDisregard') 
        @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard.delete unless @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard.blank?
        @R_VA_CaidSpouseExcessUserEarnedIncomeDisregard = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseExcessUserEarnedIncomeDisregard', :text => 'R_VA_CaidSpouseExcessUserEarnedIncomeDisregard', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 87, :web_calc_id => @R_VA_CaidSpouseExcessUserEarnedIncomeDisregardId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidSpouseCountEarnAmtNoDivideId =          WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmtNoDivide') 
        @R_VA_CaidSpouseCountEarnAmtNoDivide = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountEarnAmtNoDivide') 
        @R_VA_CaidSpouseCountEarnAmtNoDivide.delete unless @R_VA_CaidSpouseCountEarnAmtNoDivide.blank?
        @R_VA_CaidSpouseCountEarnAmtNoDivide = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountEarnAmtNoDivide', :text => 'R_VA_CaidSpouseCountEarnAmtNoDivide', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 90, :web_calc_id => @R_VA_CaidSpouseExcessUserEarnedIncomeDisregardId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidSpouseCountEarnAmtNoBWEId =          WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmtNoBWE') 
        @R_VA_CaidSpouseCountEarnAmtNoBWE = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountEarnAmtNoBWE') 
        @R_VA_CaidSpouseCountEarnAmtNoBWE.delete unless @R_VA_CaidSpouseCountEarnAmtNoBWE.blank?
        @R_VA_CaidSpouseCountEarnAmtNoBWE = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountEarnAmtNoBWE', :text => 'R_VA_CaidSpouseCountEarnAmtNoBWE', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 93, :web_calc_id => @R_VA_CaidSpouseCountEarnAmtNoBWEId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidSpouseCountEarnAmtId =          WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmt') 
        @R_VA_CaidSpouseCountEarnAmt = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountEarnAmt') 
        @R_VA_CaidSpouseCountEarnAmt.delete unless @R_VA_CaidSpouseCountEarnAmt.blank?
        @R_VA_CaidSpouseCountEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountEarnAmt', :text => 'R_VA_CaidSpouseCountEarnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 96, :web_calc_id => @R_VA_CaidSpouseCountEarnAmtId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidSpouseCountIncomeAmtNoPASSId =          WebCalc.find_by_name('R_VA_CaidSpouseCountIncomeAmtNoPASS') 
        @R_VA_CaidSpouseCountIncomeAmtNoPASS = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountIncomeAmtNoPASS') 
        @R_VA_CaidSpouseCountIncomeAmtNoPASS.delete unless @R_VA_CaidSpouseCountIncomeAmtNoPASS.blank?
        @R_VA_CaidSpouseCountIncomeAmtNoPASS = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountIncomeAmtNoPASS', :text => 'R_VA_CaidSpouseCountIncomeAmtNoPASS', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 99, :web_calc_id => @R_VA_CaidSpouseCountIncomeAmtNoPASSId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidSpouseCountIncomeAmtId =          WebCalc.find_by_name('R_VA_CaidSpouseCountIncomeAmt') 
        @R_VA_CaidSpouseCountIncomeAmt = WebNumericalResult.find_by_name('R_VA_CaidSpouseCountIncomeAmt') 
        @R_VA_CaidSpouseCountIncomeAmt.delete unless @R_VA_CaidSpouseCountIncomeAmt.blank?
        @R_VA_CaidSpouseCountIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidSpouseCountIncomeAmt', :text => 'R_VA_CaidSpouseCountIncomeAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 102, :web_calc_id => @R_VA_CaidSpouseCountIncomeAmtId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidCoupleCountUnearnAmtId =          WebCalc.find_by_name('R_VA_CaidCoupleCountUnearnAmt') 
        @R_VA_CaidCoupleCountUnearnAmt = WebNumericalResult.find_by_name('R_VA_CaidCoupleCountUnearnAmt') 
        @R_VA_CaidCoupleCountUnearnAmt.delete unless @R_VA_CaidCoupleCountUnearnAmt.blank?
        @R_VA_CaidCoupleCountUnearnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleCountUnearnAmt', :text => 'R_VA_CaidCoupleCountUnearnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 105, :web_calc_id => @R_VA_CaidCoupleCountUnearnAmtId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidCoupleCountEarnAmtId =          WebCalc.find_by_name('R_VA_CaidCoupleCountEarnAmt') 
        @R_VA_CaidCoupleCountEarnAmt = WebNumericalResult.find_by_name('R_VA_CaidCoupleCountEarnAmt') 
        @R_VA_CaidCoupleCountEarnAmt.delete unless @R_VA_CaidCoupleCountEarnAmt.blank?
        @R_VA_CaidCoupleCountEarnAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleCountEarnAmt', :text => 'R_VA_CaidCoupleCountEarnAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 108, :web_calc_id => @R_VA_CaidCoupleCountEarnAmtId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidCoupleCountIncomeAmtId =          WebCalc.find_by_name('R_VA_CaidCoupleCountIncomeAmt') 
        @R_VA_CaidCoupleCountIncomeAmt = WebNumericalResult.find_by_name('R_VA_CaidCoupleCountIncomeAmt') 
        @R_VA_CaidCoupleCountIncomeAmt.delete unless @R_VA_CaidCoupleCountIncomeAmt.blank?
        @R_VA_CaidCoupleCountIncomeAmt = WebNumericalResult.create!(:name => 'R_VA_CaidCoupleCountIncomeAmt', :text => 'R_VA_CaidCoupleCountIncomeAmt', :result_type =>"currency_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 111, :web_calc_id => @R_VA_CaidCoupleCountIncomeAmtId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidLtcHomeEquityLimitExceedId =          WebCalc.find_by_name('R_VA_CaidLtcHomeEquityLimitExceed') 
        @R_VA_CaidLtcHomeEquityLimitExceed = WebNumericalResult.find_by_name('R_VA_CaidLtcHomeEquityLimitExceed') 
        @R_VA_CaidLtcHomeEquityLimitExceed.delete unless @R_VA_CaidLtcHomeEquityLimitExceed.blank?
        @R_VA_CaidLtcHomeEquityLimitExceed = WebNumericalResult.create!(:name => 'R_VA_CaidLtcHomeEquityLimitExceed', :text => 'R_VA_CaidLtcHomeEquityLimitExceed', :result_type =>"string_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 114, :web_calc_id => @R_VA_CaidLtcHomeEquityLimitExceedId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidUserResourceEligId =          WebCalc.find_by_name('R_VA_CaidUserResourceElig') 
        @R_VA_CaidUserResourceElig = WebNumericalResult.find_by_name('R_VA_CaidUserResourceElig') 
        @R_VA_CaidUserResourceElig.delete unless @R_VA_CaidUserResourceElig.blank?
        @R_VA_CaidUserResourceElig = WebNumericalResult.create!(:name => 'R_VA_CaidUserResourceElig', :text => 'R_VA_CaidUserResourceElig', :result_type =>"string_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 117, :web_calc_id => @R_VA_CaidUserResourceEligId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidUserGetOrApplyLtcId =          WebCalc.find_by_name('R_VA_CaidUserGetOrApplyLtc') 
        @R_VA_CaidUserGetOrApplyLtc = WebNumericalResult.find_by_name('R_VA_CaidUserGetOrApplyLtc') 
        @R_VA_CaidUserGetOrApplyLtc.delete unless @R_VA_CaidUserGetOrApplyLtc.blank?
        @R_VA_CaidUserGetOrApplyLtc = WebNumericalResult.create!(:name => 'R_VA_CaidUserGetOrApplyLtc', :text => 'R_VA_CaidUserGetOrApplyLtc', :result_type =>"string_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 120, :web_calc_id => @R_VA_CaidUserGetOrApplyLtcId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidUserLtcEligId =          WebCalc.find_by_name('R_VA_CaidUserLtcElig') 
        @R_VA_CaidUserLtcElig = WebNumericalResult.find_by_name('R_VA_CaidUserLtcElig') 
        @R_VA_CaidUserLtcElig.delete unless @R_VA_CaidUserLtcElig.blank?
        @R_VA_CaidUserLtcElig = WebNumericalResult.create!(:name => 'R_VA_CaidUserLtcElig', :text => 'R_VA_CaidUserLtcElig', :result_type =>"string_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 123, :web_calc_id => @R_VA_CaidUserLtcEligId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidUserSpouseBothGetOrApplyId =          WebCalc.find_by_name('R_VA_CaidUserSpouseBothGetOrApply') 
        @R_VA_CaidUserSpouseBothGetOrApply = WebNumericalResult.find_by_name('R_VA_CaidUserSpouseBothGetOrApply') 
        @R_VA_CaidUserSpouseBothGetOrApply.delete unless @R_VA_CaidUserSpouseBothGetOrApply.blank?
        @R_VA_CaidUserSpouseBothGetOrApply = WebNumericalResult.create!(:name => 'R_VA_CaidUserSpouseBothGetOrApply', :text => 'R_VA_CaidUserSpouseBothGetOrApply', :result_type =>"string_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 126, :web_calc_id => @R_VA_CaidUserSpouseBothGetOrApplyId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidUserSpouseSameCovGroupId =          WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup') 
        @R_VA_CaidUserSpouseSameCovGroup = WebNumericalResult.find_by_name('R_VA_CaidUserSpouseSameCovGroup') 
        @R_VA_CaidUserSpouseSameCovGroup.delete unless @R_VA_CaidUserSpouseSameCovGroup.blank?
        @R_VA_CaidUserSpouseSameCovGroup = WebNumericalResult.create!(:name => 'R_VA_CaidUserSpouseSameCovGroup', :text => 'R_VA_CaidUserSpouseSameCovGroup', :result_type =>"string_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 129, :web_calc_id => @R_VA_CaidUserSpouseSameCovGroupId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)

        @R_VA_CaidUserOrSpouseGetsWorksOr300pctId =          WebCalc.find_by_name('R_VA_CaidUserOrSpouseGetsWorksOr300pct') 
        @R_VA_CaidUserOrSpouseGetsWorksOr300pct = WebNumericalResult.find_by_name('R_VA_CaidUserOrSpouseGetsWorksOr300pct') 
        @R_VA_CaidUserOrSpouseGetsWorksOr300pct.delete unless @R_VA_CaidUserOrSpouseGetsWorksOr300pct.blank?
        @R_VA_CaidUserOrSpouseGetsWorksOr300pct = WebNumericalResult.create!(:name => 'R_VA_CaidUserOrSpouseGetsWorksOr300pct', :text => 'R_VA_CaidUserOrSpouseGetsWorksOr300pct', :result_type =>"string_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
        RShowWorkVar = (RShowWorkVar.calculate manager)
        if RShowWorkVar then
          true
        else
         false
        end", 
        :order => 132, :web_calc_id => @R_VA_CaidUserOrSpouseGetsWorksOr300pctId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)


        @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceEligId =          WebCalc.find_by_name('R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig') 
         @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig = WebNumericalResult.find_by_name('R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig') 
         @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig.delete unless @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig.blank?
         @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig = WebNumericalResult.create!(:name => 'R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig', :text => 'R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig', :result_type =>"string_detail", :display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
         RShowWorkVar = (RShowWorkVar.calculate manager)
         if RShowWorkVar then
           true
         else
          false
         end", 
         :order => 135, :web_calc_id => @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceEligId.id, :group_id => @BobWebVACalcCalcSheetDisplay.id)
=end      
  end

  def self.down
  end
end
