class UpdateWebcalcRvaCaidUserResourceElig < ActiveRecord::Migration
  def self.up
    
    
      require 'wwweb_session_manager'  

   #   45 52	2222	IF any of the retreived answers to the Exceed-Resource questions (2160-2220 except 2215) are YES, then R_VA_CaidUserResourceElig = Ineligible, ELSE IF any are NO, then Eligible, ELSE N/A	R_VA_CaidUserResourceElig
   

      @R_VA_CaidUserResourceElig = WebCalc.find_by_name('R_VA_CaidUserResourceElig')
          if @R_VA_CaidUserResourceElig.blank? then
            @R_VA_CaidUserResourceElig  = WebCalc.new(:name => 'R_VA_CaidUserResourceElig')
          end
      #@R_VA_CaidUserResourceElig  = WebCalc.new(:name => 'R_VA_CaidUserResourceElig')

     # =IF(OR(E237="YES";E238="YES";E239="YES";E240="YES";E241="YES";E242="YES";E243="YES";E244="YES";E250="YES");"Ineligible";
     #  IF(OR(E237="NO"; E238="NO"; E239="NO"; E240="NO"; E241="NO"; E242="NO"; E243="NO"; E244="NO"; E250="NO");"Eligible";"N/A"))
     #237 CaidMostGroupsResourceLimitExceed
     #238 CaidCoupleMostGroupsResourceLimitExceed
     #239 Caid80PctFplResourceLimitExceed
     #240 CaidCouple80PctFplResourceLimitExceed
     #241 CaidQdwiResourceLimitExceed
     #242 CaidCoupleQdwiResourceLimitExceed
     #243 CaidQmbSlmbQiResourceLimitExceed
     #244 CaidCoupleQmbSlmbQiResourceLimitExceed
     #250 CaidGetWorksResourceLimitExceed

     @R_VA_CaidUserResourceElig.operation = "
     CaidMostGroupsResourceLimitExceed = manager.get_answer_by_question_name('CaidMostGroupsResourceLimitExceed')
     CaidCoupleMostGroupsResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleMostGroupsResourceLimitExceed')
     Caid80PctFplResourceLimitExceed = manager.get_answer_by_question_name('Caid80PctFplResourceLimitExceed')
     CaidCouple80PctFplResourceLimitExceed = manager.get_answer_by_question_name('CaidCouple80PctFplResourceLimitExceed')
     CaidQdwiResourceLimitExceed = manager.get_answer_by_question_name('CaidQdwiResourceLimitExceed')
     CaidCoupleQdwiResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleQdwiResourceLimitExceed')
     CaidQmbSlmbQiResourceLimitExceed = manager.get_answer_by_question_name('CaidQmbSlmbQiResourceLimitExceed')
     CaidCoupleQmbSlmbQiResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleQmbSlmbQiResourceLimitExceed')
     CaidGetWorksResourceLimitExceed = manager.get_answer_by_question_name('CaidGetWorksResourceLimitExceed')
     if CaidMostGroupsResourceLimitExceed == 'Yes' || CaidCoupleMostGroupsResourceLimitExceed  == 'Yes' ||  Caid80PctFplResourceLimitExceed == 'Yes' ||  CaidCouple80PctFplResourceLimitExceed == 'Yes' ||  
        CaidQdwiResourceLimitExceed == 'Yes' || CaidCoupleQdwiResourceLimitExceed == 'Yes' ||
       CaidQmbSlmbQiResourceLimitExceed  == 'Yes' || CaidCoupleQmbSlmbQiResourceLimitExceed == 'Yes' ||   CaidGetWorksResourceLimitExceed == 'Yes' then
       return 'Ineligible'
     elsif CaidMostGroupsResourceLimitExceed == 'No' || CaidCoupleMostGroupsResourceLimitExceed  == 'No' || Caid80PctFplResourceLimitExceed == 'No' || CaidCouple80PctFplResourceLimitExceed == 'No' || 
       CaidQdwiResourceLimitExceed == 'No' || CaidCoupleQdwiResourceLimitExceed == 'No' ||
       CaidQmbSlmbQiResourceLimitExceed  == 'No' || CaidCoupleQmbSlmbQiResourceLimitExceed == 'No' ||   CaidGetWorksResourceLimitExceed == 'No' then 
        return 'Eligible'
     else 
       return 'N/A'
     end
     "
     
     #AWS TODO Remove this code to clear out the operation field
     @R_VA_CaidUserResourceElig.operation = ""
     
     puts @R_VA_CaidUserResourceElig.inspect
     
     @R_VA_CaidUserResourceElig.save!
  end

  def self.down
  end
end
