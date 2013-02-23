class CreateRCaidIneligUnearnWebcalc < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  
     
     #319	IF SsiGet = YES AND ((SsdiDac <> YES AND RSsiIneligUnearn = TRUE) OR (SsdiDac = YES AND RDacCaidIneligUnearnNoDi = TRUE)) , THEN RCaidIneligUnearn = TRUE, ELSE FALSE	RCaidIneligUnearn
           
     @RCaidIneligUnearn  = WebCalc.new(:name => 'RCaidIneligUnearn')
     @RCaidIneligUnearn.operation = "
      SsiGet = manager.get_answer_by_question_name('SsiGet')
      SsdiDac = manager.get_answer_by_question_name('SsdiDac')
      RSsiIneligUnearn = WebCalc.find_by_name('RSsiIneligUnearn')
      RSsiIneligUnearn = (RSsiIneligUnearn.calculate manager)
      RDacCaidIneligUnearnNoDi = WebCalc.find_by_name('RDacCaidIneligUnearnNoDi')
      RDacCaidIneligUnearnNoDi = (RDacCaidIneligUnearnNoDi.calculate manager)
      if ((SsdiDac != 'Yes' && RSsiIneligUnearn == true) || (SsdiDac == 'Yes' && RDacCaidIneligUnearnNoDi == true)) then
        true
      else
       false
      end
     "
     @RCaidIneligUnearn.save!
  end

  def self.down
  end
end
