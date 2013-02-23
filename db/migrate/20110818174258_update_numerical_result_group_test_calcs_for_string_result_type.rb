class UpdateNumericalResultGroupTestCalcsForStringResultType < ActiveRecord::Migration
  def self.up
    
      @R_SsdiSgaExceeded = WebNumericalResult.find_by_name('R_SsdiSgaExceeded') 
      @R_SsdiSgaExceeded.update_attribute(:result_type, "string_detail")  unless @R_SsdiSgaExceeded.blank?

      @R_SsdiBenefitStops = WebNumericalResult.find_by_name('R_SsdiBenefitStops') 
      @R_SsdiBenefitStops.update_attribute(:result_type, "string_detail")  unless @R_SsdiBenefitStops.blank?
    
    
      @R_SsdiEseCeases = WebNumericalResult.find_by_name('R_SsdiEseCeases') 
      @R_SsdiEseCeases.update_attribute(:result_type, "string_detail")  unless @R_SsdiEseCeases.blank?
    
      @R_SpouseSsdiSgaExceeded = WebNumericalResult.find_by_name('R_SpouseSsdiSgaExceeded') 
      @R_SpouseSsdiSgaExceeded.update_attribute(:result_type, "string_detail")  unless @R_SpouseSsdiSgaExceeded.blank?
    
      @R_SpouseSsdiBenefitStops = WebNumericalResult.find_by_name('R_SpouseSsdiBenefitStops') 
      @R_SpouseSsdiBenefitStops.update_attribute(:result_type, "string_detail")  unless @R_SpouseSsdiBenefitStops.blank?
    
      @R_SpouseSsdiEseCeases = WebNumericalResult.find_by_name('R_SpouseSsdiEseCeases') 
      @R_SpouseSsdiEseCeases.update_attribute(:result_type, "string_detail")  unless @R_SpouseSsdiEseCeases.blank?
    
      @R_SgaExceededNotSsiElig = WebNumericalResult.find_by_name('R_SgaExceededNotSsiElig') 
      @R_SgaExceededNotSsiElig.update_attribute(:result_type, "string_detail")  unless @R_SgaExceededNotSsiElig.blank?
    
      @R_SsiSpousalDeemCalcsUsed = WebNumericalResult.find_by_name('R_SsiSpousalDeemCalcsUsed') 
      @R_SsiSpousalDeemCalcsUsed.update_attribute(:result_type, "string_detail")  unless @R_SsiSpousalDeemCalcsUsed.blank?
    
      @RDacNotCaidEligUnearnWithDi = WebNumericalResult.find_by_name('RDacNotCaidEligUnearnWithDi') 
      @RDacNotCaidEligUnearnWithDi.update_attribute(:result_type, "string_detail")  unless @RDacNotCaidEligUnearnWithDi.blank?
    
      @RDacCaidIneligUnearnNoDi = WebNumericalResult.find_by_name('RDacCaidIneligUnearnNoDi') 
      @RDacCaidIneligUnearnNoDi.update_attribute(:result_type, "string_detail")  unless @RDacCaidIneligUnearnNoDi.blank?
    
      @RSpouseDacCaidIneligUnearnNoDi = WebNumericalResult.find_by_name('RSpouseDacCaidIneligUnearnNoDi') 
      @RSpouseDacCaidIneligUnearnNoDi.update_attribute(:result_type, "string_detail")  unless @RSpouseDacCaidIneligUnearnNoDi.blank?
    
      @RSsiIneligUnearn = WebNumericalResult.find_by_name('RSsiIneligUnearn') 
      @RSsiIneligUnearn.update_attribute(:result_type, "string_detail")  unless @RSsiIneligUnearn.blank?
    
      @RCaidIneligUnearn = WebNumericalResult.find_by_name('RCaidIneligUnearn') 
      @RCaidIneligUnearn.update_attribute(:result_type, "string_detail")  unless @RCaidIneligUnearn.blank?
    
      @RSpouseCaidIneligUnearn = WebNumericalResult.find_by_name('RSpouseCaidIneligUnearn') 
      @RSpouseCaidIneligUnearn.update_attribute(:result_type, "string_detail")  unless @RSpouseCaidIneligUnearn.blank?
    
      @RSsiResourceLimitExceed = WebNumericalResult.find_by_name('RSsiResourceLimitExceed') 
      @RSsiResourceLimitExceed.update_attribute(:result_type, "string_detail")  unless @RSsiResourceLimitExceed.blank?
    
      @RCaidResourceLimitExceed = WebNumericalResult.find_by_name('RCaidResourceLimitExceed') 
      @RCaidResourceLimitExceed.update_attribute(:result_type, "string_detail")  unless @RCaidResourceLimitExceed.blank?
    
      @R1619bIneligUnearnOrResources = WebNumericalResult.find_by_name('R1619bIneligUnearnOrResources') 
      @R1619bIneligUnearnOrResources.update_attribute(:result_type, "string_detail")  unless @R1619bIneligUnearnOrResources.blank?
    
      @R1619bIneligThreshold = WebNumericalResult.find_by_name('R1619bIneligThreshold') 
      @R1619bIneligThreshold.update_attribute(:result_type, "string_detail")  unless @R1619bIneligThreshold.blank?
    
      @RSpouse1619bIneligThreshold = WebNumericalResult.find_by_name('RSpouse1619bIneligThreshold') 
      @RSpouse1619bIneligThreshold.update_attribute(:result_type, "string_detail")  unless @RSpouse1619bIneligThreshold.blank?
    
      @R1619bElig = WebNumericalResult.find_by_name('R1619bElig') 
      @R1619bElig.update_attribute(:result_type, "string_detail")  unless @R1619bElig.blank?
    
      @RSpouse1619bElig = WebNumericalResult.find_by_name('RSpouse1619bElig') 
      @RSpouse1619bElig.update_attribute(:result_type, "string_detail")  unless @RSpouse1619bElig.blank?
    
      @RLoseSSIFinancial = WebNumericalResult.find_by_name('RLoseSSIFinancial') 
      @RLoseSSIFinancial.update_attribute(:result_type, "string_detail")  unless @RLoseSSIFinancial.blank?

       
  end

  def self.down
  end
end
