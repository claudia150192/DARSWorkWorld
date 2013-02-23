class AddInitialDataToNumericResultType < ActiveRecord::Migration
  def self.up
    #currency_detail
    #currency_total
    #string_detail
    #string_total
    #date_detail
    #SSDI_Cash_Benefit_Self SSDI_Cash_Benefit_Spouse SSI_Cash_Benefit_Self SSI_Cash_Benefit_SSI_Couple Other_Unearned_Income_Self Other_Unearned_Income_Spouse Earned_Income_Self Earned_Income_Spouse Earned Income Received (Self) Earned_Income_Received_Spouse Total Gross Income)
    #DisabilityRelatedWorkExpenses SpouseDisabilityRelatedWorkExpenses OtherWorkExpenses SpouseOtherWorkExpenses EmployabilityInvestments SpouseEmployabilityInvestments
    #MedicarePartBPremium SpouseMedicarePartBPremium EstimatedTaxes SpouseEstimatedTaxes OtherEstimatedExpenses SpouseOtherEstimatedExpenses TotalExpensesEmployabilityInvestments TotalGrossIncome TotExpensesEmployabilityInvestments INCOMEminusEXPENSES
    #DeemedParentalIncome DeemedUnearnedSpousalIncome DeemedEarnedSpousalIncome TotalDeemedSpousalIncome 
    #StudentEarnedIncomeExclusion IRWE SgaIRWE TotBwe totPASS TrialWorkAndGrace Subsidy 
    
    @web_numerical_result_SSDI_Cash_Benefit_Self = WebNumericalResult.find_by_name('SSDI_Cash_Benefit_Self')
    @web_numerical_result_SSDI_Cash_Benefit_Self.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SSDI_Cash_Benefit_Self.blank?
      
    @web_numerical_result_SSDI_Cash_Benefit_Spouse = WebNumericalResult.find_by_name('SSDI_Cash_Benefit_Spouse')
    @web_numerical_result_SSDI_Cash_Benefit_Spouse.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SSDI_Cash_Benefit_Spouse.blank?
    
    @web_numerical_result_SSI_Cash_Benefit_Self = WebNumericalResult.find_by_name('SSI_Cash_Benefit_Self')
    @web_numerical_result_SSI_Cash_Benefit_Self.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SSI_Cash_Benefit_Self.blank?
    
    @web_numerical_result_SSI_Cash_Benefit_SSI_Couple = WebNumericalResult.find_by_name('SSI_Cash_Benefit_SSI_Couple')
    @web_numerical_result_SSI_Cash_Benefit_SSI_Couple.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SSI_Cash_Benefit_SSI_Couple.blank?

    @web_numerical_result_SSI_Other_Unearned_Income_Self = WebNumericalResult.find_by_name('Other_Unearned_Income_Self')
    @web_numerical_result_SSI_Other_Unearned_Income_Self.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SSI_Other_Unearned_Income_Self.blank?
    
    @web_numerical_result_SSI_Other_Unearned_Income_Spouse = WebNumericalResult.find_by_name('Other_Unearned_Income_Spouse')
    @web_numerical_result_SSI_Other_Unearned_Income_Spouse.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SSI_Other_Unearned_Income_Spouse.blank?

    @web_numerical_result_Earned_Income_Self = WebNumericalResult.find_by_name('Earned_Income_Self')
    @web_numerical_result_Earned_Income_Self.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_Earned_Income_Self.blank?
    
    @web_numerical_result_Earned_Income_Spouse = WebNumericalResult.find_by_name('Earned_Income_Spouse')
    @web_numerical_result_Earned_Income_Spouse.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_Earned_Income_Spouse.blank?
    
    @web_numerical_result_Earned_Income_Received_Self = WebNumericalResult.find_by_name('Earned Income Received (Self)')
    @web_numerical_result_Earned_Income_Received_Self.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_Earned_Income_Received_Self.blank?
    
    @web_numerical_result_Earned_Income_Received_Spouse = WebNumericalResult.find_by_name('Earned_Income_Received_Spouse')
    @web_numerical_result_Earned_Income_Received_Spouse.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_Earned_Income_Received_Spouse.blank?
    
    @web_numerical_result_Total_Gross_Income = WebNumericalResult.find_by_name('Total Gross Income)')
    @web_numerical_result_Total_Gross_Income.update_attribute(:result_type, 'currency_total') unless @web_numerical_result_Total_Gross_Income.blank?
    
    @web_numerical_result_DisabilityRelatedWorkExpenses = WebNumericalResult.find_by_name('DisabilityRelatedWorkExpenses')
    @web_numerical_result_DisabilityRelatedWorkExpenses.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_DisabilityRelatedWorkExpenses.blank?
    
    @web_numerical_result_SpouseDisabilityRelatedWorkExpenses = WebNumericalResult.find_by_name('SpouseDisabilityRelatedWorkExpenses')
    @web_numerical_result_SpouseDisabilityRelatedWorkExpenses.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SpouseDisabilityRelatedWorkExpenses.blank?
    
    @web_numerical_result_OtherWorkExpenses = WebNumericalResult.find_by_name('OtherWorkExpenses')
    @web_numerical_result_OtherWorkExpenses.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_OtherWorkExpenses.blank?
    
    @web_numerical_result_SpouseOtherWorkExpenses = WebNumericalResult.find_by_name('SpouseOtherWorkExpenses')
    @web_numerical_result_SpouseOtherWorkExpenses.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SpouseOtherWorkExpenses.blank?
    
    @web_numerical_result_EmployabilityInvestments = WebNumericalResult.find_by_name('EmployabilityInvestments')
    @web_numerical_result_EmployabilityInvestments.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_EmployabilityInvestments.blank?
    
    @web_numerical_result_SpouseEmployabilityInvestments = WebNumericalResult.find_by_name('SpouseEmployabilityInvestments')
    @web_numerical_result_SpouseEmployabilityInvestments.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SpouseEmployabilityInvestments.blank?
    
    @web_numerical_result_MedicarePartBPremium = WebNumericalResult.find_by_name('MedicarePartBPremium')
    @web_numerical_result_MedicarePartBPremium.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_MedicarePartBPremium.blank?
    
    @web_numerical_result_SpouseMedicarePartBPremium = WebNumericalResult.find_by_name('SpouseMedicarePartBPremium')
    @web_numerical_result_SpouseMedicarePartBPremium.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SpouseMedicarePartBPremium.blank?
    
    @web_numerical_result_EstimatedTaxes = WebNumericalResult.find_by_name('EstimatedTaxes')
    @web_numerical_result_EstimatedTaxes.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_EstimatedTaxes.blank?
    
    @web_numerical_result_SpouseEstimatedTaxes = WebNumericalResult.find_by_name('SpouseEstimatedTaxes')
    @web_numerical_result_SpouseEstimatedTaxes.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SpouseEstimatedTaxes.blank?
    
    @web_numerical_result_OtherEstimatedExpenses = WebNumericalResult.find_by_name('OtherEstimatedExpenses')
    @web_numerical_result_OtherEstimatedExpenses.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_OtherEstimatedExpenses.blank?
    
    @web_numerical_result_SpouseOtherEstimatedExpenses = WebNumericalResult.find_by_name('SpouseOtherEstimatedExpenses')
    @web_numerical_result_SpouseOtherEstimatedExpenses.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SpouseOtherEstimatedExpenses.blank?
    
    @web_numerical_result_TotalExpensesEmployabilityInvestments = WebNumericalResult.find_by_name('TotalExpensesEmployabilityInvestments')
    @web_numerical_result_TotalExpensesEmployabilityInvestments.update_attribute(:result_type, 'currency_total') unless @web_numerical_result_TotalExpensesEmployabilityInvestments.blank?
    
    @web_numerical_result_TotalGrossIncome2 = WebNumericalResult.find_by_name('TotalGrossIncome')
    @web_numerical_result_TotalGrossIncome2.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_TotalGrossIncome2.blank?
    
    @web_numerical_result_TotExpensesEmployabilityInvestments = WebNumericalResult.find_by_name('TotExpensesEmployabilityInvestments')
    @web_numerical_result_TotExpensesEmployabilityInvestments.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_TotExpensesEmployabilityInvestments.blank?
    
    @web_numerical_result_INCOMEminusEXPENSES = WebNumericalResult.find_by_name('INCOMEminusEXPENSES')
    @web_numerical_result_INCOMEminusEXPENSES.update_attribute(:result_type, 'currency_total') unless @web_numerical_result_INCOMEminusEXPENSES.blank?
    
    @web_numerical_result_DeemedParentalIncome = WebNumericalResult.find_by_name('DeemedParentalIncome')
    @web_numerical_result_DeemedParentalIncome.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_DeemedParentalIncome.blank?
    
    @web_numerical_result_DeemedUnearnedSpousalIncome = WebNumericalResult.find_by_name('DeemedUnearnedSpousalIncome')
    @web_numerical_result_DeemedUnearnedSpousalIncome.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_DeemedUnearnedSpousalIncome.blank?

    @web_numerical_result_DeemedEarnedSpousalIncome = WebNumericalResult.find_by_name('DeemedEarnedSpousalIncome')
    @web_numerical_result_DeemedEarnedSpousalIncome.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_DeemedEarnedSpousalIncome.blank?
    
    @web_numerical_result_TotalDeemedSpousalIncome = WebNumericalResult.find_by_name('TotalDeemedSpousalIncome')
    @web_numerical_result_TotalDeemedSpousalIncome.update_attribute(:result_type, 'currency_total') unless @web_numerical_result_TotalDeemedSpousalIncome.blank?
    
    @web_numerical_result_StudentEarnedIncomeExclusion = WebNumericalResult.find_by_name('StudentEarnedIncomeExclusion')
    @web_numerical_result_StudentEarnedIncomeExclusion.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_StudentEarnedIncomeExclusion.blank?
    
    @web_numerical_result_IRWE = WebNumericalResult.find_by_name('IRWE')
    @web_numerical_result_IRWE.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_IRWE.blank?
    
    @web_numerical_result_SgaIRWE = WebNumericalResult.find_by_name('SgaIRWE')
    @web_numerical_result_SgaIRWE.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SgaIRWE.blank?
    
    @web_numerical_result_TotBwe = WebNumericalResult.find_by_name('TotBwe')
    @web_numerical_result_TotBwe.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_TotBwe.blank?
    
    @web_numerical_result_totPASS = WebNumericalResult.find_by_name('totPASS')
    @web_numerical_result_totPASS.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_totPASS.blank?
    
    @web_numerical_result_TrialWorkAndGrace = WebNumericalResult.find_by_name('TrialWorkAndGrace')
    @web_numerical_result_TrialWorkAndGrace.update_attribute(:result_type, 'string_detail') unless @web_numerical_result_TrialWorkAndGrace.blank?
    
    @web_numerical_result_Subsidy = WebNumericalResult.find_by_name('Subsidy')
    @web_numerical_result_Subsidy.update_attribute(:result_type, 'string_detail') unless @web_numerical_result_Subsidy.blank?
    
  end

  def self.down
    
    @web_numerical_result_Subsidy = WebNumericalResult.find_by_name('Subsidy')
    @web_numerical_result_Subsidy.update_attribute(:result_type, '') unless @web_numerical_result_Subsidy.blank?
    
    @web_numerical_result_TrialWorkAndGrace = WebNumericalResult.find_by_name('TrialWorkAndGrace')
    @web_numerical_result_TrialWorkAndGrace.update_attribute(:result_type, '') unless @web_numerical_result_TrialWorkAndGrace.blank?
    
    @web_numerical_result_totPASS = WebNumericalResult.find_by_name('totPASS')
    @web_numerical_result_totPASS.update_attribute(:result_type, '') unless @web_numerical_result_totPASS.blank?
    
    @web_numerical_result_TotBwe = WebNumericalResult.find_by_name('TotBwe')
    @web_numerical_result_TotBwe.update_attribute(:result_type, '') unless @web_numerical_result_TotBwe.blank?
    
    @web_numerical_result_SgaIRWE = WebNumericalResult.find_by_name('SgaIRWE')
    @web_numerical_result_SgaIRWE.update_attribute(:result_type, '') unless @web_numerical_result_SgaIRWE.blank?
    
    @web_numerical_result_IRWE = WebNumericalResult.find_by_name('IRWE')
    @web_numerical_result_IRWE.update_attribute(:result_type, '') unless @web_numerical_result_IRWE.blank?
    
    @web_numerical_result_StudentEarnedIncomeExclusion = WebNumericalResult.find_by_name('StudentEarnedIncomeExclusion')
    @web_numerical_result_StudentEarnedIncomeExclusion.update_attribute(:result_type, '') unless @web_numerical_result_StudentEarnedIncomeExclusion.blank?
    
    @web_numerical_result_TotalDeemedSpousalIncome = WebNumericalResult.find_by_name('TotalDeemedSpousalIncome')
    @web_numerical_result_TotalDeemedSpousalIncome.update_attribute(:result_type, '') unless @web_numerical_result_TotalDeemedSpousalIncome.blank?
    
    @web_numerical_result_DeemedEarnedSpousalIncome = WebNumericalResult.find_by_name('DeemedEarnedSpousalIncome')
    @web_numerical_result_DeemedEarnedSpousalIncome.update_attribute(:result_type, '') unless @web_numerical_result_DeemedEarnedSpousalIncome.blank?
    
    @web_numerical_result_DeemedUnearnedSpousalIncome = WebNumericalResult.find_by_name('DeemedUnearnedSpousalIncome')
    @web_numerical_result_DeemedUnearnedSpousalIncome.update_attribute(:result_type, '') unless @web_numerical_result_DeemedUnearnedSpousalIncome.blank?
    
    @web_numerical_result_DeemedParentalIncome = WebNumericalResult.find_by_name('DeemedParentalIncome')
    @web_numerical_result_DeemedParentalIncome.update_attribute(:result_type, '') unless @web_numerical_result_DeemedParentalIncome.blank?
    
    @web_numerical_result_INCOMEminusEXPENSES = WebNumericalResult.find_by_name('INCOMEminusEXPENSES')
    @web_numerical_result_INCOMEminusEXPENSES.update_attribute(:result_type, '') unless @web_numerical_result_INCOMEminusEXPENSES.blank?
    
    @web_numerical_result_TotExpensesEmployabilityInvestments = WebNumericalResult.find_by_name('TotExpensesEmployabilityInvestments')
    @web_numerical_result_TotExpensesEmployabilityInvestments.update_attribute(:result_type, '') unless @web_numerical_result_TotExpensesEmployabilityInvestments.blank?
    
    @web_numerical_result_TotalGrossIncome2 = WebNumericalResult.find_by_name('TotalGrossIncome')
    @web_numerical_result_TotalGrossIncome2.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_TotalGrossIncome2.blank?
    
    @web_numerical_result_TotalExpensesEmployabilityInvestments = WebNumericalResult.find_by_name('TotalExpensesEmployabilityInvestments')
    @web_numerical_result_TotalExpensesEmployabilityInvestments.update_attribute(:result_type, '') unless @web_numerical_result_TotalExpensesEmployabilityInvestments.blank?
    
    @web_numerical_result_SpouseOtherEstimatedExpenses = WebNumericalResult.find_by_name('SpouseOtherEstimatedExpenses')
    @web_numerical_result_SpouseOtherEstimatedExpenses.update_attribute(:result_type, '') unless @web_numerical_result_SpouseOtherEstimatedExpenses.blank?
    
    @web_numerical_result_OtherEstimatedExpenses = WebNumericalResult.find_by_name('OtherEstimatedExpenses')
    @web_numerical_result_OtherEstimatedExpenses.update_attribute(:result_type, '') unless @web_numerical_result_OtherEstimatedExpenses.blank?
       
    @web_numerical_result_SpouseEstimatedTaxes = WebNumericalResult.find_by_name('SpouseEstimatedTaxes')
    @web_numerical_result_SpouseEstimatedTaxes.update_attribute(:result_type, '') unless @web_numerical_result_SpouseEstimatedTaxes.blank?
    
    @web_numerical_result_EstimatedTaxes = WebNumericalResult.find_by_name('EstimatedTaxes')
    @web_numerical_result_EstimatedTaxes.update_attribute(:result_type, '') unless @web_numerical_result_EstimatedTaxes.blank?
    
    @web_numerical_result_SpouseMedicarePartBPremium = WebNumericalResult.find_by_name('SpouseMedicarePartBPremium')
    @web_numerical_result_SpouseMedicarePartBPremium.update_attribute(:result_type, '') unless @web_numerical_result_SpouseMedicarePartBPremium.blank?
   
    @web_numerical_result_MedicarePartBPremium = WebNumericalResult.find_by_name('MedicarePartBPremium')
    @web_numerical_result_MedicarePartBPremium.update_attribute(:result_type, '') unless @web_numerical_result_MedicarePartBPremium.blank?
      
    @web_numerical_result_SpouseEmployabilityInvestments = WebNumericalResult.find_by_name('SpouseEmployabilityInvestments')
    @web_numerical_result_SpouseEmployabilityInvestments.update_attribute(:result_type, '') unless @web_numerical_result_SpouseEmployabilityInvestments.blank?
    
    @web_numerical_result_EmployabilityInvestments = WebNumericalResult.find_by_name('EmployabilityInvestments')
    @web_numerical_result_EmployabilityInvestments.update_attribute(:result_type, '') unless @web_numerical_result_EmployabilityInvestments.blank?
    
    @web_numerical_result_SpouseOtherWorkExpenses = WebNumericalResult.find_by_name('SpouseOtherWorkExpenses')
    @web_numerical_result_SpouseOtherWorkExpenses.update_attribute(:result_type, '') unless @web_numerical_result_SpouseOtherWorkExpenses.blank?
    
    @web_numerical_result_OtherWorkExpenses = WebNumericalResult.find_by_name('OtherWorkExpenses')
    @web_numerical_result_OtherWorkExpenses.update_attribute(:result_type, '') unless @web_numerical_result_OtherWorkExpenses.blank?
    
    @web_numerical_result_SpouseDisabilityRelatedWorkExpenses = WebNumericalResult.find_by_name('SpouseDisabilityRelatedWorkExpenses')
    @web_numerical_result_SpouseDisabilityRelatedWorkExpenses.update_attribute(:result_type, '') unless @web_numerical_result_SpouseDisabilityRelatedWorkExpenses.blank?
    
    @web_numerical_result_DisabilityRelatedWorkExpenses = WebNumericalResult.find_by_name('DisabilityRelatedWorkExpenses')
    @web_numerical_result_DisabilityRelatedWorkExpenses.update_attribute(:result_type, '') unless @web_numerical_result_DisabilityRelatedWorkExpenses.blank?
    
    @web_numerical_result_Total_Gross_Income = WebNumericalResult.find_by_name('Total Gross Income)')
    @web_numerical_result_Total_Gross_Income.update_attribute(:result_type, '') unless @web_numerical_result_Total_Gross_Income.blank?
     
    @web_numerical_result_Earned_Income_Received_Spouse = WebNumericalResult.find_by_name('Earned_Income_Received_Spouse')
    @web_numerical_result_Earned_Income_Received_Spouse.update_attribute(:result_type, '') unless @web_numerical_result_Earned_Income_Received_Spouse.blank?
    
    @web_numerical_result_Earned_Income_Received_Self = WebNumericalResult.find_by_name('Earned Income Received (Self)')
    @web_numerical_result_Earned_Income_Received_Self.update_attribute(:result_type, '') unless @web_numerical_result_Earned_Income_Received_Self.blank?
    
    @web_numerical_result_Earned_Income_Spouse = WebNumericalResult.find_by_name('Earned_Income_Spouse')
    @web_numerical_result_Earned_Income_Spouse.update_attribute(:result_type, '') unless @web_numerical_result_Earned_Income_Spouse.blank?
    
    @web_numerical_result_Earned_Income_Self = WebNumericalResult.find_by_name('Earned_Income_Self')
    @web_numerical_result_Earned_Income_Self.update_attribute(:result_type, '') unless @web_numerical_result_Earned_Income_Self.blank?
    
    @web_numerical_result_SSI_Other_Unearned_Income_Spouse = WebNumericalResult.find_by_name('Other_Unearned_Income_Spouse')
    @web_numerical_result_SSI_Other_Unearned_Income_Spouse.update_attribute(:result_type, '') unless @web_numerical_result_SSI_Other_Unearned_Income_Spouse.blank?
    
    @web_numerical_result_SSI_Other_Unearned_Income_Self = WebNumericalResult.find_by_name('Other_Unearned_Income_Self')
    @web_numerical_result_SSI_Other_Unearned_Income_Self.update_attribute(:result_type, '') unless @web_numerical_result_SSI_Other_Unearned_Income_Self.blank?
    
    @web_numerical_result_SSI_Cash_Benefit_SSI_Couple = WebNumericalResult.find_by_name('SSI_Cash_Benefit_SSI_Couple')
    @web_numerical_result_SSI_Cash_Benefit_SSI_Couple.update_attribute(:result_type, '') unless @web_numerical_result_SSI_Cash_Benefit_SSI_Couple.blank?
    
    @web_numerical_result_SSI_Cash_Benefit_Self = WebNumericalResult.find_by_name('SSI_Cash_Benefit_Self')
    @web_numerical_result_SSI_Cash_Benefit_Self.update_attribute(:result_type, '') unless @web_numerical_result_SSI_Cash_Benefit_Self.blank?
    
    @web_numerical_result_SSDI_Cash_Benefit_Spouse = WebNumericalResult.find_by_name('SSDI_Cash_Benefit_Spouse')
    @web_numerical_result_SSDI_Cash_Benefit_Spouse.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_SSDI_Cash_Benefit_Spouse.blank?
    
    @web_numerical_result_SSDI_Cash_Benefit_Self = WebNumericalResult.find_by_name('SSDI_Cash_Benefit_Self')
    @web_numerical_result_SSDI_Cash_Benefit_Self.update_attribute(:result_type, '') unless @web_numerical_result_SSDI_Cash_Benefit_Self.blank?
  end
end
