class CreateRSpouseCaidIneligUnearnWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
     
     #321	IF SpouseSsiGet = YES AND ((SpouseSsdiDac <> YES AND RSsiIneligUnearn = TRUE) OR (SpouseSsdiDac = YES AND RSpouseDacCaidIneligUnearnNoDi = TRUE)) , THEN RSpouseCaidIneligUnearn = TRUE, ELSE FALSE	RSpouseCaidIneligUnearn
                
     @RSpouseCaidIneligUnearn  = WebCalc.new(:name => 'RSpouseCaidIneligUnearn')
     @RSpouseCaidIneligUnearn.operation = "
      SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
      SpouseSsdiDac = manager.get_answer_by_question_name('SpouseSsdiDac')
      RSsiIneligUnearn = WebCalc.find_by_name('RSsiIneligUnearn')
      RSsiIneligUnearn = (RSsiIneligUnearn.calculate manager)
      RSpouseDacCaidIneligUnearnNoDi = WebCalc.find_by_name('RSpouseDacCaidIneligUnearnNoDi')
      RSpouseDacCaidIneligUnearnNoDi = (RSpouseDacCaidIneligUnearnNoDi.calculate manager)
      if ( SpouseSsiGet == 'Yes' && ((SpouseSsdiDac != 'Yes' && RSsiIneligUnearn == true) || (SpouseSsdiDac == 'Yes' && RSpouseDacCaidIneligUnearnNoDi == true))) then
        true
      else
       false
      end
     "
     @RSpouseCaidIneligUnearn.save!
  end

  def self.down
  end
end
