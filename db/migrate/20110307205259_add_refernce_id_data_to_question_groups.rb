class AddRefernceIdDataToQuestionGroups < ActiveRecord::Migration
  def self.up
    
    @QuestionGroup_Start_Up_Information = QuestionGroup.find(:first, :conditions => ['name = ?', 'Start-Up Information'])
    @QuestionGroup_Start_Up_Information.update_attribute(:reference_id, '1.0') unless @QuestionGroup_Start_Up_Information.blank?
    
    @QuestionGroup_User_Information = QuestionGroup.find(:first, :conditions => ['name = ?', 'User Information'])
    @QuestionGroup_User_Information.update_attribute(:reference_id, '2.0') unless @QuestionGroup_User_Information.blank?

    @QuestionGroup_Household_Info = QuestionGroup.find(:first, :conditions => ['name = ?', 'Household Info'])
    @QuestionGroup_Household_Info.update_attribute(:reference_id, '3.0') unless @QuestionGroup_Household_Info.blank?
    
    @QuestionGroup_Benefits = QuestionGroup.find(:first, :conditions => ['name = ?', 'Benefits'])
    @QuestionGroup_Benefits.update_attribute(:reference_id, '4.0') unless @QuestionGroup_Benefits.blank?
    
    @QuestionGroup_SSI = QuestionGroup.find(:first, :conditions => ['name = ?', 'SSI'])
    @QuestionGroup_SSI.update_attribute(:reference_id, '5.0') unless @QuestionGroup_SSI.blank?
    
    @QuestionGroup_Medicaid = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicaid'])
    @QuestionGroup_Medicaid.update_attribute(:reference_id, '6.0') unless @QuestionGroup_Medicaid.blank?
    
    @QuestionGroup_SSDI = QuestionGroup.find(:first, :conditions => ['name = ?', 'SSDI'])
    @QuestionGroup_SSDI.update_attribute(:reference_id, '7.0') unless @QuestionGroup_SSDI.blank?
    
    @QuestionGroup_Medicare = QuestionGroup.find(:first, :conditions => ['name = ?', 'Medicare'])
    @QuestionGroup_Medicare.update_attribute(:reference_id, '8.0') unless @QuestionGroup_Medicare.blank?
    
    @QuestionGroup_SPOUSE_BENEFITS = QuestionGroup.find(:first, :conditions => ['name = ?', 'SPOUSE BENEFITS'])
    @QuestionGroup_SPOUSE_BENEFITS.update_attribute(:reference_id, '9.0') unless @QuestionGroup_SPOUSE_BENEFITS.blank?
    
    @QuestionGroup_Spouse_SSI = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse SSI'])
    @QuestionGroup_Spouse_SSI.update_attribute(:reference_id, '10.0') unless @QuestionGroup_Spouse_SSI.blank?
    
    @QuestionGroup_Spouse_Medicaid = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Medicaid'])
    @QuestionGroup_Spouse_Medicaid.update_attribute(:reference_id, '11.0') unless @QuestionGroup_Spouse_Medicaid.blank?
    
    @QuestionGroup_Spouse_SSDI = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse SSDI'])
    @QuestionGroup_Spouse_SSDI.update_attribute(:reference_id, '12.0') unless @QuestionGroup_Spouse_SSDI.blank?
    
    @QuestionGroup_Spouse_Medicare = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Medicare'])
    @QuestionGroup_Spouse_Medicare.update_attribute(:reference_id, '13.0') unless @QuestionGroup_Spouse_Medicare.blank?
    
    @QuestionGroup_INCOME_RESOURCES = QuestionGroup.find(:first, :conditions => ['name = ?','INCOME & RESOURCES'])
    @QuestionGroup_INCOME_RESOURCES.update_attribute(:reference_id, '14.0') unless @QuestionGroup_INCOME_RESOURCES.blank?
    
    @QuestionGroup_Deeming = QuestionGroup.find(:first, :conditions => ['name = ?', 'Deeming'])
    @QuestionGroup_Deeming.update_attribute(:reference_id, '15.0') unless @QuestionGroup_Deeming.blank?
    
    @QuestionGroup_Resources = QuestionGroup.find(:first, :conditions => ['name = ?', 'Resources'])
    @QuestionGroup_Resources.update_attribute(:reference_id, '16.0') unless @QuestionGroup_Resources.blank?
    
    @QuestionGroup_In_Kind_Support = QuestionGroup.find(:first, :conditions => ['name = ?',  'In-Kind Support'])
    @QuestionGroup_In_Kind_Support.update_attribute(:reference_id, '17.0') unless @QuestionGroup_In_Kind_Support.blank?
    
    @QuestionGroup_Own_Unearned_Income = QuestionGroup.find(:first, :conditions => ['name = ?', 'Own Unearned Income'])
    @QuestionGroup_Own_Unearned_Income.update_attribute(:reference_id, '18.0') unless @QuestionGroup_Own_Unearned_Income.blank?
    
    @QuestionGroup_Spouse_Unearned_Income = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse Unearned Income'])
    @QuestionGroup_Spouse_Unearned_Income.update_attribute(:reference_id, '19.0') unless @QuestionGroup_Spouse_Unearned_Income.blank?
    
    @QuestionGroup_Own_Earned_Income = QuestionGroup.find(:first, :conditions => ['name = ?', 'Own Earned Income'])
    @QuestionGroup_Own_Earned_Income.update_attribute(:reference_id, '20.0') unless @QuestionGroup_Own_Earned_Income.blank?
    
    @QuestionGroup_Spouse_Earned_Income = QuestionGroup.find(:first, :conditions => ['name = ?',  'Spouse Earned Income'])
    @QuestionGroup_Spouse_Earned_Income.update_attribute(:reference_id, '21.0') unless @QuestionGroup_Spouse_Earned_Income.blank?
    
    @QuestionGroup_EXPENSES = QuestionGroup.find(:first, :conditions => ['name = ?', 'EXPENSES'])
    @QuestionGroup_EXPENSES.update_attribute(:reference_id, '22.0') unless @QuestionGroup_EXPENSES.blank?
    
    @QuestionGroup_Work_Expenses = QuestionGroup.find(:first, :conditions => ['name = ?', 'Work Expenses'])
    @QuestionGroup_Work_Expenses.update_attribute(:reference_id, '23.0') unless @QuestionGroup_Work_Expenses.blank?
    
    @QuestionGroup_Other_Expenses = QuestionGroup.find(:first, :conditions => ['name = ?', 'Other Expenses'])
    @QuestionGroup_Other_Expenses.update_attribute(:reference_id, '24.0') unless @QuestionGroup_Other_Expenses.blank?
    
    @QuestionGroup_Employability_Investments = QuestionGroup.find(:first, :conditions => ['name = ?',  'Employability Investments'])
    @QuestionGroup_Employability_Investments.update_attribute(:reference_id, '25.0') unless @QuestionGroup_Employability_Investments.blank?
    
    @QuestionGroup_WORK_INCENTIVES = QuestionGroup.find(:first, :conditions => ['name = ?', 'WORK INCENTIVES'])
    @QuestionGroup_WORK_INCENTIVES.update_attribute(:reference_id, '26.0') unless @QuestionGroup_WORK_INCENTIVES.blank?
    
    @QuestionGroup_SEIE = QuestionGroup.find(:first, :conditions => ['name = ?', 'Student Earned Income Exclusion (SEIE)'])
    @QuestionGroup_SEIE.update_attribute(:reference_id, '27.0') unless @QuestionGroup_SEIE.blank?
    
    @QuestionGroup_IRWE = QuestionGroup.find(:first, :conditions => ['name = ?', 'Impairment-Related Work Expense (IRWE)'])
    @QuestionGroup_IRWE.update_attribute(:reference_id, '28.0') unless @QuestionGroup_IRWE.blank?
    
    @QuestionGroup_BWE = QuestionGroup.find(:first, :conditions => ['name = ?', 'Blind Work Expense (BWE)'])
    @QuestionGroup_BWE.update_attribute(:reference_id, '29.0') unless @QuestionGroup_BWE.blank?
    
    @QuestionGroup_PASS = QuestionGroup.find(:first, :conditions => ['name = ?', 'Plan for Achieving Self-Support (PASS)'])
    @QuestionGroup_PASS.update_attribute(:reference_id, '30.0') unless @QuestionGroup_PASS.blank?
    
    @QuestionGroup_Trial_Work_Period = QuestionGroup.find(:first, :conditions => ['name = ?', 'Trial Work Period (TWP)'])
    @QuestionGroup_Trial_Work_Period.update_attribute(:reference_id, '31.0') unless @QuestionGroup_Trial_Work_Period.blank?
      
    @QuestionGroup_Subsidies_SSDI = QuestionGroup.find(:first, :conditions => ['name = ?', 'Subsidies (SSDI)'])
    @QuestionGroup_Subsidies_SSDI.update_attribute(:reference_id, '32.0') unless @QuestionGroup_Subsidies_SSDI.blank?
    
    @QuestionGroup_Benefit_Amount_Adjustments = QuestionGroup.find(:first, :conditions => ['name = ?',  'Benefit Amount Adjustments'])
    @QuestionGroup_Benefit_Amount_Adjustments.update_attribute(:reference_id, '33.0') unless @QuestionGroup_Benefit_Amount_Adjustments.blank?
    
    @QuestionGroup_Own_SSDI_Benefit_Adjustments = QuestionGroup.find(:first, :conditions => ['name = ?',  'Own SSDI Benefit Adjustments'])
    @QuestionGroup_Own_SSDI_Benefit_Adjustments.update_attribute(:reference_id, '34.0') unless @QuestionGroup_Own_SSDI_Benefit_Adjustments.blank?
    
    @QuestionGroup_Spouse_SSDI_Benefit_Adjustments = QuestionGroup.find(:first, :conditions => ['name = ?', 'Spouse SSDI Benefit Adjustments'])
    @QuestionGroup_Spouse_SSDI_Benefit_Adjustments.update_attribute(:reference_id, '35.0') unless @QuestionGroup_Spouse_SSDI_Benefit_Adjustments.blank?
    
    @QuestionGroup_SSI_Benefit_Adjustments = QuestionGroup.find(:first, :conditions => ['name = ?', 'SSI Benefit Adjustments'])
    @QuestionGroup_SSI_Benefit_Adjustments.update_attribute(:reference_id, '36.0') unless @QuestionGroup_SSI_Benefit_Adjustments.blank?
    
    @QuestionGroup_Numerical_Results = QuestionGroup.find(:first, :conditions => ['name = ?', 'Numerical Results'])
    @QuestionGroup_Numerical_Results.update_attribute(:reference_id, '37.0') unless @QuestionGroup_Numerical_Results.blank?
    
  end

  def self.down
  end
end
