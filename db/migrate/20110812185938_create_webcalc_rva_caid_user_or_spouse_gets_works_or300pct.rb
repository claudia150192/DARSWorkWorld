class CreateWebcalcRvaCaidUserOrSpouseGetsWorksOr300pct < ActiveRecord::Migration
  def self.up
    
       require 'wwweb_session_manager'  

  # 52	2227.2	IF R_VA_CaidUserSpouseSameCovGroup = TRUE AND (VA_CaidGetCoveredGroup OR VA_CaidSpouseGetCoveredGroup) = (MEDICAID WORKS OR 300% SSI), THEN R_VA_CaidUserOrSpouseGetsWorksOr300pct = YES, ELSE NO	
  # R_VA_CaidUserOrSpouseGetsWorksOr300pct	NO	We don't want to use the resource limits for an assistance unit of 2 if user and/or spouse gets WORKS or 300% SSI. Those two covered groups use assistance unit of 2 for applying and assistance unit of 1 once they get Medicaid under one of those covered groups.  For all of the other covered groups, the assistance units are the same for getting and applying.
     @R_VA_CaidUserOrSpouseGetsWorksOr300pct = WebCalc.find_by_name('R_VA_CaidUserOrSpouseGetsWorksOr300pct')
     if @R_VA_CaidUserOrSpouseGetsWorksOr300pct.blank? then
         @R_VA_CaidUserOrSpouseGetsWorksOr300pct  = WebCalc.new(:name => 'R_VA_CaidUserOrSpouseGetsWorksOr300pct')
     end

      #IF R_VA_CaidUserSpouseSameCovGroup = TRUE AND (VA_CaidGetCoveredGroup OR VA_CaidSpouseGetCoveredGroup) = (MEDICAID WORKS OR 300% SSI), THEN R_VA_CaidUserOrSpouseGetsWorksOr300pct = YES, ELSE NO
      #=IF(AND(E270=1;OR(E226="MEDICAID WORKS";E226="300% SSI";E264="MEDICAID WORKS";E264="300% SSI"));"YES";"NO")
      #270 R_VA_CaidUserSpouseSameCovGroup
      #226 VA_CaidGetCoveredGroup
      #264 VA_CaidSpouseGetCoveredGroup
      
    @R_VA_CaidUserOrSpouseGetsWorksOr300pct.operation = "
    R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
    R_VA_CaidUserSpouseSameCovGroup = (R_VA_CaidUserSpouseSameCovGroup.calculate manager)
    VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
    VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
    if (R_VA_CaidUserSpouseSameCovGroup == true  && (VA_CaidGetCoveredGroup == 'MEDICAID WORKS' || VA_CaidGetCoveredGroup == '300% SSI' ||
        VA_CaidSpouseGetCoveredGroup == 'MEDICAID WORKS' || VA_CaidSpouseGetCoveredGroup == '300% SSI')) then
       true
    else
      false
   end
    "
    #AWS TODO Remove this code to clear out the operation field
    @R_VA_CaidUserOrSpouseGetsWorksOr300pct.operation = ""
    
      @R_VA_CaidUserOrSpouseGetsWorksOr300pct.save!
  end

  def self.down
  end
end
