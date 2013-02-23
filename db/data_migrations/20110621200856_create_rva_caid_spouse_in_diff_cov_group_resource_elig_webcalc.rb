class CreateRvaCaidSpouseInDiffCovGroupResourceEligWebcalc < ActiveRecord::Migration
  def self.up
    
         require 'wwweb_session_manager'  
 
      #   45	2244	IF R_VA_CaidUserSpouseSameCovGroup = Different AND (any of the answers to the resource questions above are YES THEN R_VA_CaidSpouseInDiffCovGroupResourceElig = Ineligible, 
      #   OR IF any of those answers are NO), THEN Eligible, ELSE N/A	R_VA_CaidSpouseInDiffCovGroupResourceElig
            
     @R_VA_CaidSpouseInDiffCovGroupResourceElig = WebCalc.find_by_name('R_VA_CaidSpouseInDiffCovGroupResourceElig')
     if @R_VA_CaidSpouseInDiffCovGroupResourceElig.blank? then
       @R_VA_CaidSpouseInDiffCovGroupResourceElig  = WebCalc.new(:name => 'R_VA_CaidSpouseInDiffCovGroupResourceElig')
     end
 
    #=IF(E247="Different";IF(OR(E252="YES";E253="YES";E254="YES";E255="YES";E256="YES");"Ineligible";IF(OR(E252="NO";E253="NO";E254="NO";E255="NO";E256="NO");"Eligible";"N/A"));"N/A")
    #247 R_VA_CaidUserSpouseSameCovGroup
    #252 CaidSpouseCoupleMostGroupsResourceLimitExceed
    #253 CaidSpouseCoupleQdwiResourceLimitExceed
    #254 CaidSpouseCoupleQmbSlmbQiResourceLimitExceed
    #255 CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed
    #256 CaidSpouseGetWorksResourceLimitExceed
      
    @R_VA_CaidSpouseInDiffCovGroupResourceElig.operation = "
    R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
    R_VA_CaidUserSpouseSameCovGroup = (R_VA_CaidUserSpouseSameCovGroup.calculate manager)
    CaidSpouseCoupleMostGroupsResourceLimitExceed = manager.get_answer_by_question_name('CaidSpouseCoupleMostGroupsResourceLimitExceed')
    CaidSpouseCoupleQdwiResourceLimitExceed = manager.get_answer_by_question_name('CaidSpouseCoupleQdwiResourceLimitExceed')
    CaidSpouseCoupleQmbSlmbQiResourceLimitExceed = manager.get_answer_by_question_name('CaidSpouseCoupleQmbSlmbQiResourceLimitExceed')
    CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed = manager.get_answer_by_question_name('CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed')
    CaidSpouseGetWorksResourceLimitExceed = manager.get_answer_by_question_name('CaidSpouseGetWorksResourceLimitExceed')
    
    if (R_VA_CaidUserSpouseSameCovGroup == false &&
        (CaidSpouseCoupleMostGroupsResourceLimitExceed == 'Yes' || CaidSpouseCoupleQdwiResourceLimitExceed  == 'Yes' || CaidSpouseCoupleQmbSlmbQiResourceLimitExceed == 'Yes' ||
        CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed == 'Yes' || CaidSpouseGetWorksResourceLimitExceed == 'Yes')) then
    
       return 'Ineligible' 
    
    elsif   (R_VA_CaidUserSpouseSameCovGroup == false &&
         (CaidSpouseCoupleMostGroupsResourceLimitExceed == 'No' || CaidSpouseCoupleQdwiResourceLimitExceed  == 'No' || CaidSpouseCoupleQmbSlmbQiResourceLimitExceed == 'No' ||
         CaidSpouseApplyLongTermCareUserCommunitySpouseResourceLimitExceed == 'No' || CaidSpouseGetWorksResourceLimitExceed == 'No')) then 
    
      return 'Eligible'
    
    else
      return 'N/A'
      
    end"
    @R_VA_CaidSpouseInDiffCovGroupResourceElig.save!
  end

  def self.down
  end
end
