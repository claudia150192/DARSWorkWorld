class CreateRvaCaidSpouseInSameCovGroupResourceEligWebcalc < ActiveRecord::Migration
  def self.up
         require 'wwweb_session_manager'  
  
      #   45	2228	IF R_VA_CaidUserSpouseSameCovGroup = Same AND = IF any of the retreived answers to the Couple Exceed-Resource questions are YES, then R_VA_CaidSpouseInSameCovGroupResourceElig = Ineligible, 
      #      ELSE IF any are NO, then Eligible, ELSE N/A	R_VA_CaidSpouseInSameCovGroupResourceElig
      
  
      @R_VA_CaidSpouseInSameCovGroupResourceElig = WebCalc.find_by_name('R_VA_CaidSpouseInSameCovGroupResourceElig')
      if @R_VA_CaidSpouseInSameCovGroupResourceElig.blank? then
        @R_VA_CaidSpouseInSameCovGroupResourceElig  = WebCalc.new(:name => 'R_VA_CaidSpouseInSameCovGroupResourceElig')
      end
  
     #=IF(E247="Same";IF(OR(E234="YES";E236="YES";E238="YES");"Ineligible";IF(OR(E234="NO";E236="NO";E238="NO");"Eligible";"N/A"));"N/A")
     #247 R_VA_CaidUserSpouseSameCovGroup
     #234 CaidCoupleMostGroupsResourceLimitExceed
     #236 CaidCoupleQdwiResourceLimitExceed
     #238 CaidCoupleQmbSlmbQiResourceLimitExceed
       
     @R_VA_CaidSpouseInSameCovGroupResourceElig.operation = "
     R_VA_CaidUserSpouseSameCovGroup = manager.get_answer_by_question_name('R_VA_CaidUserSpouseSameCovGroup')
     CaidCoupleMostGroupsResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleMostGroupsResourceLimitExceed')
     CaidCoupleQdwiResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleQdwiResourceLimitExceed')
     CaidCoupleQmbSlmbQiResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleQmbSlmbQiResourceLimitExceed')
     if (CaidCoupleMostGroupsResourceLimitExceed == 'Yes' || CaidCoupleMostGroupsResourceLimitExceed  == 'Yes'  ||  CaidCoupleQmbSlmbQiResourceLimitExceed == 'Yes') then
       return 'Ineligible'
     elsif (CaidCoupleMostGroupsResourceLimitExceed == 'No' || CaidCoupleMostGroupsResourceLimitExceed  == 'No' || CaidCoupleQmbSlmbQiResourceLimitExceed == 'No') then 
        return 'Eligible'
     else 
       return 'N/A'
     end"
     @R_VA_CaidSpouseInSameCovGroupResourceElig.save!
  end

  def self.down
  end
end
