class CreateRSsiIneligUnearnWebcalc < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  
     
     #317	IF SsiGet = YES AND RSsiUnearnEligAddedPassNeedAmt > 0, THEN RSsiIneligUnearn = TRUE, ELSE FALSE	RSsiIneligUnearn
      
     @RSsiIneligUnearn  = WebCalc.new(:name => 'RSsiIneligUnearn')
     @RSsiIneligUnearn.operation = "
      SsiGet = manager.get_answer_by_question_name('SsiGet')
      RSsiUnearnEligAddedPassNeedAmt = WebCalc.find_by_name('RSsiUnearnEligAddedPassNeedAmt')
      RSsiUnearnEligAddedPassNeedAmt = Float(RSsiUnearnEligAddedPassNeedAmt.calculate manager)
      if (SsiGet == 'Yes' && RSsiUnearnEligAddedPassNeedAmt > 0 ) then
        true
      else
       false
      end
     "
     @RSsiIneligUnearn.save!
  end

  def self.down
  end
end
