class CreateRvaCaidSpouseCountEarnAmtNoDivideWebcalc < ActiveRecord::Migration
  def self.up
       require 'wwweb_session_manager'  
 
 #  1720	Countable earned income before dividing by 2 (can't be < 0)	R_VA_CaidSpouseCountEarnAmtNoDivide
 
    @R_VA_CaidSpouseCountEarnAmtNoDivide = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmtNoDivide')
    if @R_VA_CaidSpouseCountEarnAmtNoDivide.blank? then
       @R_VA_CaidSpouseCountEarnAmtNoDivide  = WebCalc.new(:name => 'R_VA_CaidSpouseCountEarnAmtNoDivide')
    end

    #1720
    #=MAX(0;E174-SUM(E175:E181))
    #e174 R_VA_CaidSpouseEarnAmt
   #minus
    #E176 R_VA_CaidSpouseUnusedGenExclude
    #E178 R_VA_CaidSpouseExcessUserEarnedIncomeDisregard
    #e180 SpouseSsiCaidIrweAmt
    

    @R_VA_CaidSpouseCountEarnAmtNoDivide.operation = "
    R_VA_CaidSpouseEarnAmt = WebCalc.find_by_name('R_VA_CaidSpouseEarnAmt')
    R_VA_CaidSpouseEarnAmt = Float(R_VA_CaidSpouseEarnAmt.calculate manager)
    R_VA_CaidSpouseUnusedGenExclude = WebCalc.find_by_name('R_VA_CaidSpouseUnusedGenExclude')
    R_VA_CaidSpouseUnusedGenExclude = Float(R_VA_CaidSpouseUnusedGenExclude.calculate manager)
    R_VA_CaidSpouseExcessUserEarnedIncomeDisregard = WebCalc.find_by_name('R_VA_CaidSpouseExcessUserEarnedIncomeDisregard')
    R_VA_CaidSpouseExcessUserEarnedIncomeDisregard = Float(R_VA_CaidSpouseExcessUserEarnedIncomeDisregard.calculate manager) 
    SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
    [(R_VA_CaidSpouseEarnAmt - (R_VA_CaidSpouseUnusedGenExclude - R_VA_CaidSpouseExcessUserEarnedIncomeDisregard - SpouseSsiCaidIrweAmt.to_f)), 0].max
    "
    @R_VA_CaidSpouseCountEarnAmtNoDivide.save!
  end

  def self.down
  end
end
