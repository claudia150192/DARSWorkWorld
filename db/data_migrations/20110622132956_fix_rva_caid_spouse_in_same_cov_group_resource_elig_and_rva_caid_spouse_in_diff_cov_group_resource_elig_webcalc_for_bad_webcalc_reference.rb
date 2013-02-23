class FixRvaCaidSpouseInSameCovGroupResourceEligAndRvaCaidSpouseInDiffCovGroupResourceEligWebcalcForBadWebcalcReference < ActiveRecord::Migration
  def self.up
  
        require 'wwweb_session_manager'  

     #   45	2227	IF R_VA_CaidUserSpouseBothGetOrApply = YES AND (VA_CaidGetCoveredGroup OR VA_CaidApplyCoveredGroup) = (VA_CaidSpouseGetCoveredGroup OR VA_CaidSpouseApplyCoveredGroup) [excluding same nulls], 
     #             THEN R_VA_CaidUserSpouseSameCovGroup = Same, ELSE Different	R_VA_CaidUserSpouseSameCovGroup
     #
     
    @R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
    if @R_VA_CaidUserSpouseSameCovGroup.blank? then
      @R_VA_CaidUserSpouseSameCovGroup  = WebCalc.new(:name => 'R_VA_CaidUserSpouseSameCovGroup')
    end

   #=IF(AND(E245="YES";OR(AND(E226=E230;E226<>0);AND(E226=E232;E226<>0);AND(E228=E230;E228<>0);AND(E228=E232;E228<>0)));"Same";"Different")
   #245 R_VA_CaidUserSpouseBothGetOrApply
   #226 VA_CaidGetCoveredGroup
   #230 VA_CaidSpouseGetCoveredGroup
   #232 VA_CaidSpouseApplyCoveredGroup
   #228 VA_CaidApplyCoveredGroup
   @R_VA_CaidUserSpouseSameCovGroup.operation = "
   R_VA_CaidUserSpouseBothGetOrApply = WebCalc.find_by_name('R_VA_CaidUserSpouseBothGetOrApply')
   R_VA_CaidUserSpouseBothGetOrApply = (R_VA_CaidUserSpouseBothGetOrApply.calculate manager)
   VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
   VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
   VA_CaidSpouseApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseApplyCoveredGroup')
   VA_CaidApplyCoveredGroup = manager.get_answer_by_question_name('VA_CaidApplyCoveredGroup')
   
   if (R_VA_CaidUserSpouseBothGetOrApply == true &&
      ((VA_CaidGetCoveredGroup == VA_CaidSpouseGetCoveredGroup && !(VA_CaidGetCoveredGroup.blank?)) || 
      (VA_CaidGetCoveredGroup == VA_CaidSpouseApplyCoveredGroup && !(VA_CaidGetCoveredGroup.blank?)) || 
      (VA_CaidApplyCoveredGroup == VA_CaidSpouseGetCoveredGroup && !(VA_CaidApplyCoveredGroup.blank?)) || 
      (VA_CaidApplyCoveredGroup == VA_CaidSpouseApplyCoveredGroup && !(VA_CaidApplyCoveredGroup.blank?)))) then
     true
   else 
     false
   end"
   @R_VA_CaidUserSpouseSameCovGroup.save!
   
   
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
      R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
      R_VA_CaidUserSpouseSameCovGroup = (R_VA_CaidUserSpouseSameCovGroup.calculate manager)
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
