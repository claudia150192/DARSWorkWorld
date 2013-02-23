class CreateRvaCaidUserResourceEligWebcalc < ActiveRecord::Migration
  def self.up
        require 'wwweb_session_manager'  

        #2222	IF any of the retreived answers to the Exceed-Resource questions are YES, then R_VA_CaidUserResourceElig = Ineligible, ELSE IF any are NO, then Eligible, ELSE N/A	R_VA_CaidUserResourceElig
        
       @R_VA_CaidUserResourceElig = WebCalc.find_by_name('R_VA_CaidUserResourceElig')
       if @R_VA_CaidUserResourceElig.blank? then
         @R_VA_CaidUserResourceElig  = WebCalc.new(:name => 'R_VA_CaidUserResourceElig')
       end

      #=IF(OR(E233="YES";E234="YES";E235="YES";E236="YES";E237="YES";E238="YES";E239="YES";E240="YES");"Ineligible";IF(OR(E233="NO";E234="NO";E235="NO";E236="NO";E237="NO";E238="NO";E239="NO";E240="NO");"Eligible";"N/A"))
      #233 CaidMostGroupsResourceLimitExceed
      #234 CaidCoupleMostGroupsResourceLimitExceed
      #235 CaidQdwiResourceLimitExceed
      #236 CaidCoupleQdwiResourceLimitExceed
      #237 CaidQmbSlmbQiResourceLimitExceed
      #238 CaidCoupleQmbSlmbQiResourceLimitExceed
      #239 CaidApplyLongTermCareCommunitySpouseResourceLimitExceed
      #240 CaidGetWorksResourceLimitExceed
      

      @R_VA_CaidUserResourceElig.operation = "
      CaidMostGroupsResourceLimitExceed = manager.get_answer_by_question_name('CaidMostGroupsResourceLimitExceed')
      CaidCoupleMostGroupsResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleMostGroupsResourceLimitExceed')
      CaidQdwiResourceLimitExceed = manager.get_answer_by_question_name('CaidQdwiResourceLimitExceed')
      CaidCoupleQdwiResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleQdwiResourceLimitExceed')
      CaidQmbSlmbQiResourceLimitExceed = manager.get_answer_by_question_name('CaidQmbSlmbQiResourceLimitExceed')
      CaidCoupleQmbSlmbQiResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleQmbSlmbQiResourceLimitExceed')
      CaidApplyLongTermCareCommunitySpouseResourceLimitExceed = manager.get_answer_by_question_name('CaidApplyLongTermCareCommunitySpouseResourceLimitExceed')
      CaidGetWorksResourceLimitExceed = manager.get_answer_by_question_name('CaidGetWorksResourceLimitExceed')
      if CaidMostGroupsResourceLimitExceed == 'Yes' || CaidCoupleMostGroupsResourceLimitExceed  == 'Yes'  ||  CaidQdwiResourceLimitExceed == 'Yes' || CaidCoupleQdwiResourceLimitExceed == 'Yes' ||
        CaidQmbSlmbQiResourceLimitExceed  == 'Yes' || CaidCoupleQmbSlmbQiResourceLimitExceed == 'Yes' ||  CaidApplyLongTermCareCommunitySpouseResourceLimitExceed  == 'Yes' || CaidGetWorksResourceLimitExceed == 'Yes' then
        return 'Ineligible'
      elsif CaidMostGroupsResourceLimitExceed == 'No' || CaidCoupleMostGroupsResourceLimitExceed  == 'No' || CaidQdwiResourceLimitExceed == 'No' || CaidCoupleQdwiResourceLimitExceed == 'No' ||
           CaidQmbSlmbQiResourceLimitExceed  == 'No' || CaidCoupleQmbSlmbQiResourceLimitExceed == 'No' ||  CaidApplyLongTermCareCommunitySpouseResourceLimitExceed  == 'No' || CaidGetWorksResourceLimitExceed == 'No' then 
         return 'Eligible'
      else 
        return 'N/A'
      end"
      @R_VA_CaidUserResourceElig.save!
  end

  def self.down
  end
end
