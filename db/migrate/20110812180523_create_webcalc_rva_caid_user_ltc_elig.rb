class CreateWebcalcRvaCaidUserLtcElig < ActiveRecord::Migration
  def self.up
    
       require 'wwweb_session_manager'  

  #     52	2222.4	IF R_VA_CaidUserResourceElig = Eligible AND R_VA_CaidUserGetOrApplyLtc = YES AND R_VA_CaidLtcHomeEquityLimitExceed = NO AND CaidApplyLtcCommunitySpouseResourceLimitExceed <> YES, 
  # THEN R_VA_CaidUserLtcElig = Eligible, ELSE IF R_VA_CaidLtcHomeEquityLimitExceed = YES OR CaidApplyLtcCommunitySpouseResourceLimitExceed = YES, THEN R_VA_CaidUserLtcElig = Ineligible, ELSE N/A	
  #  R_VA_CaidUserLtcElig	N/A	This is supposed to take into account for Long Term Care resource eligibility the user's resource eligibility for most covered groups and to also take into account the home equity limit and (for user who is applying for LTC) the resources of a community spouse when there is one.  It should return a N/A for user who is not eligible for a covered group or who is not getting or applying for Long Term Care.
  

       @R_VA_CaidUserLtcElig = WebCalc.find_by_name('R_VA_CaidUserLtcElig')
           if @R_VA_CaidUserLtcElig.blank? then
             @R_VA_CaidUserLtcElig  = WebCalc.new(:name => 'R_VA_CaidUserLtcElig')
           end

      #IF R_VA_CaidUserResourceElig = Eligible AND R_VA_CaidUserGetOrApplyLtc = YES AND R_VA_CaidLtcHomeEquityLimitExceed = NO AND CaidApplyLtcCommunitySpouseResourceLimitExceed <> YES, THEN R_VA_CaidUserLtcElig = Eligible, ELSE IF R_VA_CaidLtcHomeEquityLimitExceed = YES OR CaidApplyLtcCommunitySpouseResourceLimitExceed = YES, THEN R_VA_CaidUserLtcElig = Ineligible, ELSE N/A
      #=IF(AND(E256="Eligible";E258="YES";E254="NO";E249<>"YES");"Eligible";IF(OR(E254="YES";E249="YES");"Ineligible";"N/A"))
      #256 R_VA_CaidUserResourceElig
      #258 R_VA_CaidUserGetOrApplyLtc
      #254 R_VA_CaidLtcHomeEquityLimitExceed
      #249 CaidApplyLtcCommunitySpouseResourceLimitExceed
      
      @R_VA_CaidUserLtcElig.operation = "
      R_VA_CaidUserResourceElig = manager.get_answer_by_question_name('R_VA_CaidUserResourceElig')
      R_VA_CaidUserGetOrApplyLtc = manager.get_answer_by_question_name('R_VA_CaidUserGetOrApplyLtc')
      R_VA_CaidLtcHomeEquityLimitExceed = manager.get_answer_by_question_name('R_VA_CaidLtcHomeEquityLimitExceed')
      CaidApplyLtcCommunitySpouseResourceLimitExceed = manager.get_answer_by_question_name('CaidApplyLtcCommunitySpouseResourceLimitExceed')
      if (R_VA_CaidUserResourceElig == 'Eligible' && R_VA_CaidUserGetOrApplyLtc == true && R_VA_CaidLtcHomeEquityLimitExceed == 'NO' && !(CaidApplyLtcCommunitySpouseResourceLimitExceed == 'Yes')) then
       return 'Eligible'
      elsif (R_VA_CaidLtcHomeEquityLimitExceed == 'YES' || CaidApplyLtcCommunitySpouseResourceLimitExceed == 'Yes') then
      
        return 'Ineligible'
      else
        return 'N/A'
     end
      "
      #AWS TODO Remove this code to clear out the operation field
      @R_VA_CaidUserLtcElig.operation = ""
      
      @R_VA_CaidUserLtcElig.save!
  end

  def self.down
  end
end
