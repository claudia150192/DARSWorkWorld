class CreateRvaCaidLtcHomeEquityLimitExceedWebcalc < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
 
 #   52	2221.2	R_VA_CaidLtcHomeEquityLimitExceed = YES IF VA_CaidLtcHomeEquityLimitProvisionallyExceed = YES AND VA_CaidSpouseOrChildLivesInHome = NO, ELSE IF VA_CaidLtcHomeEquityLimitProvisionallyExceed = NO OR VA_CaidSpouseOrChildLivesInHome = YES, THEN R_VA_CaidLtcHomeEquityLimitExceed = NO, ELSE N/A	R_VA_CaidLtcHomeEquityLimitExceed
 
    @R_VA_CaidLtcHomeEquityLimitExceed = WebCalc.find_by_name('R_VA_CaidLtcHomeEquityLimitExceed')
        if @R_VA_CaidLtcHomeEquityLimitExceed.blank? then
          @R_VA_CaidLtcHomeEquityLimitExceed  = WebCalc.new(:name => 'R_VA_CaidLtcHomeEquityLimitExceed')
        end
 
   #      R_VA_CaidLtcHomeEquityLimitExceed = YES IF VA_CaidLtcHomeEquityLimitProvisionallyExceed = YES AND VA_CaidSpouseOrChildLivesInHome = NO, 
   #    ELSE IF VA_CaidLtcHomeEquityLimitProvisionallyExceed = NO OR VA_CaidSpouseOrChildLivesInHome = YES, THEN R_VA_CaidLtcHomeEquityLimitExceed = NO, ELSE N/A
   #=IF(AND(E251="YES";E252="NO");"YES";IF(OR(E251 ="NO";E252="YES");"NO";"N/A"))
   #251 VA_CaidLtcHomeEquityLimitProvisionallyExceed   {note Bob is forced to comply with the 3 outcome possibility {Y:N:N/A} since all dependencies are not known}
   #252 VA_CaidSpouseOrChildLivesInHome
   
   @R_VA_CaidLtcHomeEquityLimitExceed.operation = "
   VA_CaidLtcHomeEquityLimitProvisionallyExceed = manager.get_answer_by_question_name('VA_CaidLtcHomeEquityLimitProvisionallyExceed')
   VA_CaidSpouseOrChildLivesInHome = manager.get_answer_by_question_name('VA_CaidSpouseOrChildLivesInHome')
   if (VA_CaidLtcHomeEquityLimitProvisionallyExceed == 'Yes' && VA_CaidSpouseOrChildLivesInHome == 'No') then
     'YES'
  elsif (VA_CaidLtcHomeEquityLimitProvisionallyExceed == 'No' || VA_CaidSpouseOrChildLivesInHome == 'Yes') then
     'NO'
  else
    'N/A'
  end
   "
   @R_VA_CaidLtcHomeEquityLimitExceed.save!
   
   
  end

  def self.down
  end
end
