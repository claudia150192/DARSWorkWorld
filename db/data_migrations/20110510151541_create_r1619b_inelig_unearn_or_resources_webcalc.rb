class CreateR1619bIneligUnearnOrResourcesWebcalc < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  

       #327	IF RCaidIneligUnearn = TRUE OR RCaidResourceLimitExceed = TRUE, THEN R1619bIneligUnearnOrResources = TRUE, ELSE FALSE	R1619bIneligUnearnOrResources
       
       @R1619bIneligUnearnOrResources  = WebCalc.new(:name => 'R1619bIneligUnearnOrResources')
       @R1619bIneligUnearnOrResources.operation = "
        RCaidIneligUnearn = WebCalc.find_by_name('RCaidIneligUnearn')
        RCaidIneligUnearn = (RCaidIneligUnearn.calculate manager)
        RCaidResourceLimitExceed = WebCalc.find_by_name('RCaidResourceLimitExceed')
        RCaidResourceLimitExceed = (RCaidResourceLimitExceed.calculate manager)
        if (RCaidIneligUnearn == true || RCaidResourceLimitExceed == true) then
          true
        else
         false
        end
       "
       @R1619bIneligUnearnOrResources.save!
  end

  def self.down
  end
end
