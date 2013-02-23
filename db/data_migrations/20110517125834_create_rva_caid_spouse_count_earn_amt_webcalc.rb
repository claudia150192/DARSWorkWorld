class CreateRvaCaidSpouseCountEarnAmtWebcalc < ActiveRecord::Migration
  def self.up
       require 'wwweb_session_manager'  

     @R_VA_CaidSpouseCountEarnAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmt')
     if @R_VA_CaidSpouseCountEarnAmt.blank? then
       @R_VA_CaidSpouseCountEarnAmt  = WebCalc.new(:name => 'R_VA_CaidSpouseCountEarnAmt')
     end

     #1800	Spouse's Countable Earned Income (Can't be < 0)	R_VA_CaidSpouseCountEarnAmt
     #=MAX(0;E184-E186)
     #e184 R_VA_CaidSpouseCountEarnAmtNoBWE
     #e186 SpouseBweAmt
    @R_VA_CaidSpouseCountEarnAmt.operation = "
    R_VA_CaidSpouseCountEarnAmtNoBWE = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmtNoBWE')
    R_VA_CaidSpouseCountEarnAmtNoBWE = Float(R_VA_CaidSpouseCountEarnAmtNoBWE.calculate manager)
    SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
    [(R_VA_CaidSpouseCountEarnAmtNoBWE - SpouseBweAmt.to_f), 0].max
    "
    @R_VA_CaidSpouseCountEarnAmt.save!
  end

  def self.down
  end
end
