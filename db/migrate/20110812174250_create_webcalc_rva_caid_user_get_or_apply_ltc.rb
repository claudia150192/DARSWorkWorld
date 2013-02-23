class CreateWebcalcRvaCaidUserGetOrApplyLtc < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  

 #   52	2222.2	If VA_CaidInstitutionServicesGet = YES OR VA_CaidWaiverServicesGet = YES OR VA_CaidInstitutionServicesApply = YES OR VA_CaidWaiverServicesApply = YES, THEN R_VA_CaidUserGetOrApplyLtc = YES	
 #R_VA_CaidUserGetOrApplyLtc
 
    @R_VA_CaidUserGetOrApplyLtc = WebCalc.find_by_name('R_VA_CaidUserGetOrApplyLtc')
        if @R_VA_CaidUserGetOrApplyLtc.blank? then
          @R_VA_CaidUserGetOrApplyLtc  = WebCalc.new(:name => 'R_VA_CaidUserGetOrApplyLtc')
        end

   # If VA_CaidInstitutionServicesGet = YES OR VA_CaidWaiverServicesGet = YES OR VA_CaidInstitutionServicesApply = YES OR VA_CaidWaiverServicesApply = YES, THEN R_VA_CaidUserGetOrApplyLtc = YES
   #=IF(OR(E245="YES";E246="YES";E247="YES";E248="YES");"YES";"NO")
   #245 VA_CaidInstitutionServicesGet
   #246 VA_CaidWaiverServicesGet
   #247 VA_CaidInstitutionServicesApply
   #248 VA_CaidWaiverServicesApply
  
   @R_VA_CaidUserGetOrApplyLtc.operation = "
   VA_CaidInstitutionServicesGet = manager.get_answer_by_question_name('VA_CaidInstitutionServicesGet')
   VA_CaidWaiverServicesGet = manager.get_answer_by_question_name('VA_CaidWaiverServicesGet')
   VA_CaidInstitutionServicesApply = manager.get_answer_by_question_name('VA_CaidInstitutionServicesApply')
   VA_CaidWaiverServicesApply = manager.get_answer_by_question_name('VA_CaidWaiverServicesApply')
   if (VA_CaidInstitutionServicesGet == 'Yes' || VA_CaidWaiverServicesGet == 'Yes' || VA_CaidInstitutionServicesApply == 'Yes' || VA_CaidWaiverServicesApply == 'Yes') then
    true
   else
     false
  end
   "
   @R_VA_CaidUserGetOrApplyLtc.save!
  end

  def self.down
  end
end
