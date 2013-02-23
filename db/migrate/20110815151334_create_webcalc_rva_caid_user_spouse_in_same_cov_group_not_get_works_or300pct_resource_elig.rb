class CreateWebcalcRvaCaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig < ActiveRecord::Migration
  def self.up
  
  require 'wwweb_session_manager'  

    # 45 47 52	2228	IF R_VA_CaidUserSpouseSameCovGroup = TRUE AND IF R_VA_CaidUserOrSpouseGetsWorksOr300pct <> YES, AND R_VA_CaidUserResourceElig = Eligible, THEN R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig = Eligible, ELSE IF IF R_VA_CaidUserOrSpouseGetsWorksOr300pct <> YES, AND R_VA_CaidUserResourceElig = Ineligible, THEN Ineligible , ELSE N/A	
    #R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig	N/A
    
       @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig = WebCalc.find_by_name('R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig')
       if @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig.blank? then
           @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig  = WebCalc.new(:name => 'R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig')
       end
 
  #     IF R_VA_CaidUserSpouseSameCovGroup = TRUE AND IF R_VA_CaidUserOrSpouseGetsWorksOr300pct <> YES, AND R_VA_CaidUserResourceElig = Eligible, THEN R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig = Eligible, 
  #    ELSE IF IF R_VA_CaidUserOrSpouseGetsWorksOr300pct <> YES, AND R_VA_CaidUserResourceElig = Ineligible, THEN Ineligible , ELSE N/A
  #=IF(AND(E270=1;E272<>"YES";E256="Eligible");"Eligible";IF(AND(E270=1;E272<>"YES";E256="Ineligible");"Ineligible";"N/A"))
      @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig.operation = "
      R_VA_CaidUserSpouseSameCovGroup = WebCalc.find_by_name('R_VA_CaidUserSpouseSameCovGroup')
      R_VA_CaidUserSpouseSameCovGroup = (R_VA_CaidUserSpouseSameCovGroup.calculate manager)
      R_VA_CaidUserOrSpouseGetsWorksOr300pct = WebCalc.find_by_name('R_VA_CaidUserOrSpouseGetsWorksOr300pct')
      R_VA_CaidUserOrSpouseGetsWorksOr300pct = (R_VA_CaidUserOrSpouseGetsWorksOr300pct.calculate manager)
      R_VA_CaidUserResourceElig = WebCalc.find_by_name('R_VA_CaidUserResourceElig')
      R_VA_CaidUserResourceElig = (R_VA_CaidUserResourceElig.calculate manager)
      if (R_VA_CaidUserSpouseSameCovGroup == true  && !(R_VA_CaidUserOrSpouseGetsWorksOr300pct == true) && R_VA_CaidUserResourceElig == 'Eligible') then
         return 'Eligible'
      elsif (R_VA_CaidUserSpouseSameCovGroup == true  && !(R_VA_CaidUserOrSpouseGetsWorksOr300pct == true) && R_VA_CaidUserResourceElig == 'Ineligible')
        return 'Ineligible'
      else
        return 'N/A'  
     end
      "
      
      #AWS TODO Remove this code to clear out the operation field
      @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig.operation = ""
      
        @R_VA_CaidUserSpouseInSameCovGroupNotGetWorksOr300pctResourceElig.save!
        
  end

  def self.down
  end
end
