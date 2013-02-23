class CreateRLoseSsiFinancialWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  

      #343	IF SsiGet = YES AND (RSsiIneligUnearn = TRUE, OR RSsiResourceLimitExceed = TRUE, OR R1619bIneligThreshold = TRUE), THEN RLoseSSIFinancial = TRUE, ELSE FALSE 	RLoseSSIFinancial
      
    @RLoseSSIFinancial  = WebCalc.new(:name => 'RLoseSSIFinancial')
    @RLoseSSIFinancial.operation = "
   SsiGet = manager.get_answer_by_question_name('SsiGet')
   RSsiIneligUnearn = WebCalc.find_by_name('RSsiIneligUnearn')
   RSsiIneligUnearn = (RSsiIneligUnearn.calculate manager)
   RSsiResourceLimitExceed = WebCalc.find_by_name('RSsiResourceLimitExceed')
   RSsiResourceLimitExceed = (RSsiResourceLimitExceed.calculate manager)
   R1619bIneligThreshold = WebCalc.find_by_name('R1619bIneligThreshold')
   R1619bIneligThreshold = (R1619bIneligThreshold.calculate manager)
   if ( SsiGet == 'Yes' && (RSsiIneligUnearn == true || RSsiResourceLimitExceed == true || R1619bIneligThreshold == true)) then
     true
   else
     false
   end
    "
    @RLoseSSIFinancial.save!
  end

  def self.down
  end
end
