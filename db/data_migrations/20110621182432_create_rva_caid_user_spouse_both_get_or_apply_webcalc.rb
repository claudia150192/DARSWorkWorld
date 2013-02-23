class CreateRvaCaidUserSpouseBothGetOrApplyWebcalc < ActiveRecord::Migration
  def self.up
    
         require 'wwweb_session_manager'  

          #45	2225	IF (CaidGet OR CaidApply = YES) AND (CaidSpouseGet OR CaidSpouseApply = YES), THEN R_VA_CaidUserSpouseBothGetOrApply = YES	R_VA_CaidUserSpouseBothGetOrApply
          

         @R_VA_CaidUserSpouseBothGetOrApply = WebCalc.find_by_name('R_VA_CaidUserSpouseBothGetOrApply')
         if @R_VA_CaidUserSpouseBothGetOrApply.blank? then
           @R_VA_CaidUserSpouseBothGetOrApply  = WebCalc.new(:name => 'R_VA_CaidUserSpouseBothGetOrApply')
         end

        #=IF(AND(OR(E225= "YES";E227="YES");OR(E229="YES";E231="YES"));"YES";"NO")
        #225 CaidGet
        #227 CaidApply
        #229 CaidSpouseGet
        #231 CaidSpouseApply
        


        @R_VA_CaidUserSpouseBothGetOrApply.operation = "
        CaidGet = manager.get_answer_by_question_name('CaidGet')
        CaidApply = manager.get_answer_by_question_name('CaidApply')
        CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
        CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
        
        if (CaidGet == 'Yes' || CaidApply  == 'Yes') && (CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') then
          true
        else 
          false
        end"
        @R_VA_CaidUserSpouseBothGetOrApply.save!
        
  end

  def self.down
  end
end
