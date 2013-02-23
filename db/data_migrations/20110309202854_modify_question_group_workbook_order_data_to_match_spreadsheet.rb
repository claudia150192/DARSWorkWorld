class ModifyQuestionGroupWorkbookOrderDataToMatchSpreadsheet < ActiveRecord::Migration
  def self.up
    @qgStartUpInformation                                   = QuestionGroup.find_by_name('Start-Up Information')
    @qgUserInformation                                      = QuestionGroup.find_by_name('User Information')
    @qgHouseholdInfo                                        = QuestionGroup.find_by_name('Household Info')
    @qgBenefits                                             = QuestionGroup.find_by_name('Benefits')
    @qgSSI                                                  = QuestionGroup.find_by_name('SSI')
    @qgMedicaid                                             = QuestionGroup.find_by_name('Medicaid')
    @qgSSDI                                                 = QuestionGroup.find_by_name('SSDI')
    @qgMedicare                                             = QuestionGroup.find_by_name('Medicare')
    @qgSPOUSEBENEFITS                                       = QuestionGroup.find_by_name('SPOUSE BENEFITS')
    @qgSpouseSSI                                            = QuestionGroup.find_by_name('Spouse SSI')
    @qgSpouseMedicaid                                       = QuestionGroup.find_by_name('Spouse Medicaid')
    @qgSpouseSSDI                                           = QuestionGroup.find_by_name('Spouse SSDI')
    @qgSpouseMedicare                                       = QuestionGroup.find_by_name('Spouse Medicare')
    @qgINCOME_RESOURCES                                     = QuestionGroup.find_by_name('INCOME & RESOURCES')
    @qgDeeming                                              = QuestionGroup.find_by_name('Deeming')
    @qgResources                                            = QuestionGroup.find_by_name('Resources')
    @qgIn_KindSupport                                       = QuestionGroup.find_by_name('In-Kind Support')
    @qgOwnUnearnedIncome                                    = QuestionGroup.find_by_name('Own Unearned Income')
    @qgSpouseUnearnedIncome                                 = QuestionGroup.find_by_name('Spouse Unearned Income')
    @qgOwnEarnedIncome                                      = QuestionGroup.find_by_name('Own Earned Income')
    @qgSpouseEarnedIncome                                   = QuestionGroup.find_by_name('Spouse Earned Income')
    @qgEXPENSES                                             = QuestionGroup.find_by_name('EXPENSES')
    @qgWorkExpenses                                         = QuestionGroup.find_by_name('Work Expenses')
    @qgOtherExpenses                                        = QuestionGroup.find_by_name('Other Expenses')
    @qgEmployabilityInvestments                             = QuestionGroup.find_by_name('Employability Investments')
    @qgWORK_INCENTIVES                                      = QuestionGroup.find_by_name('WORK INCENTIVES')
    @qgSEIE                                                 = QuestionGroup.find_by_name('Student Earned Income Exclusion (SEIE)')
    @qgIRWE                                                 = QuestionGroup.find_by_name('Impairment-Related Work Expense (IRWE)')
    @qgBWE                                                  = QuestionGroup.find_by_name('Blind Work Expense (BWE)')
    @qgPASS                                                 = QuestionGroup.find_by_name('Plan for Achieving Self-Support (PASS)')
    @qgTWP                                                  = QuestionGroup.find_by_name('Trial Work Period (TWP)')
    @qgSubsidies_SSDI                                       = QuestionGroup.find_by_name('Subsidies (SSDI)')
    @qgBenefitAmountAdjustments                             = QuestionGroup.find_by_name('Benefit Amount Adjustments')
    @qgOwnSSDIBenefitAdjustments                            = QuestionGroup.find_by_name('Own SSDI Benefit Adjustments')
    @qgSpouseSSDIBenefitAdjustments                         = QuestionGroup.find_by_name('Spouse SSDI Benefit Adjustments')
    @qgSSIBenefitAdjustments                                = QuestionGroup.find_by_name('SSI Benefit Adjustments')
        
      
   @qgStartUpInformation.update_attribute(:workbook_order,"1.00") unless @qgStartUpInformation.blank?           
   @qgUserInformation.update_attribute(:workbook_order,"2.00") unless @qgUserInformation.blank?                          
   @qgHouseholdInfo.update_attribute(:workbook_order,"7.00") unless @qgHouseholdInfo.blank?           
   @qgBenefits.update_attribute(:workbook_order,"25.00") unless @qgBenefits.blank?           
   @qgSSI.update_attribute(:workbook_order,"26.00") unless @qgSSI.blank?                                      
   @qgMedicaid.update_attribute(:workbook_order,"29.00") unless @qgMedicaid.blank?                                 
   @qgSSDI.update_attribute(:workbook_order,"34.00") unless @qgSSDI.blank?                                     
   @qgMedicare.update_attribute(:workbook_order,"44.00") unless @qgMedicare.blank?           
   @qgSPOUSEBENEFITS.update_attribute(:workbook_order,"50.00") unless @qgSPOUSEBENEFITS.blank?                           
   @qgSpouseSSI.update_attribute(:workbook_order,"51.00") unless @qgSpouseSSI.blank?                                
   @qgSpouseMedicaid.update_attribute(:workbook_order,"53.00") unless @qgSpouseMedicaid.blank?                           
   @qgSpouseSSDI.update_attribute(:workbook_order,"58.00") unless @qgSpouseSSDI.blank?           
   @qgSpouseMedicare.update_attribute(:workbook_order,"66.00") unless @qgSpouseMedicare.blank?           
   @qgINCOME_RESOURCES.update_attribute(:workbook_order,"72.00") unless @qgINCOME_RESOURCES.blank?           
   @qgDeeming.update_attribute(:workbook_order,"73.00") unless @qgDeeming.blank?           
   @qgResources.update_attribute(:workbook_order,"83.00") unless @qgResources.blank?           
   @qgIn_KindSupport.update_attribute(:workbook_order,"88.00") unless @qgIn_KindSupport.blank?           
   @qgOwnUnearnedIncome.update_attribute(:workbook_order,"92.00") unless @qgOwnUnearnedIncome.blank?           
   @qgSpouseUnearnedIncome.update_attribute(:workbook_order,"99.00") unless @qgSpouseUnearnedIncome.blank?           
   @qgOwnEarnedIncome.update_attribute(:workbook_order,"106.00") unless @qgOwnEarnedIncome.blank?           
   @qgSpouseEarnedIncome.update_attribute(:workbook_order,"111.00") unless @qgSpouseEarnedIncome.blank?           
   @qgEXPENSES.update_attribute(:workbook_order,"116.00") unless @qgEXPENSES.blank?           
   @qgWorkExpenses.update_attribute(:workbook_order,"117.00") unless @qgWorkExpenses.blank?           
   @qgOtherExpenses.update_attribute(:workbook_order,"124.00") unless @qgOtherExpenses.blank?           
   @qgEmployabilityInvestments.update_attribute(:workbook_order,"133.00") unless @qgEmployabilityInvestments.blank?           
   @qgWORK_INCENTIVES.update_attribute(:workbook_order,"136.00") unless @qgWORK_INCENTIVES.blank?           
   @qgSEIE.update_attribute(:workbook_order,"137.00") unless @qgSEIE.blank?           
   @qgIRWE.update_attribute(:workbook_order,"152.00") unless @qgIRWE.blank?           
   @qgBWE.update_attribute(:workbook_order,"157.00") unless @qgBWE.blank?           
   @qgPASS.update_attribute(:workbook_order,"160.00") unless @qgPASS.blank?           
   @qgTWP.update_attribute(:workbook_order,"163.00") unless @qgTWP.blank?           
   @qgSubsidies_SSDI.update_attribute(:workbook_order,"166.00") unless @qgSubsidies_SSDI.blank?           
   @qgBenefitAmountAdjustments.update_attribute(:workbook_order,"171.00") unless @qgBenefitAmountAdjustments.blank?           
   @qgOwnSSDIBenefitAdjustments.update_attribute(:workbook_order,"172.00") unless @qgOwnSSDIBenefitAdjustments.blank?           
   @qgSpouseSSDIBenefitAdjustments.update_attribute(:workbook_order,"179.00") unless @qgSpouseSSDIBenefitAdjustments.blank?           
   @qgSSIBenefitAdjustments.update_attribute(:workbook_order,"186.00") unless @qgSSIBenefitAdjustments.blank?           
  
  end

  def self.down
  end
end
