class CreateRvaCaidCountEarnAmtNoDivideWebcalc < ActiveRecord::Migration
  def self.up
 
   require 'wwweb_session_manager'  
   # oops Jumped one  This migration will have to do Two at once
   #1080	Amount of General Exclusion to subtract from earned income	R_VA_CaidExcessGenExclude
   #=IF(E109>E111;E109-E111;0)
   #e109 RateGenExcludeAmt
   #e111 R_VA_CaidCountUnearnNoNeedIncomeAmt
   
   @R_VA_CaidExcessGenExclude  = WebCalc.new(:name => 'R_VA_CaidExcessGenExclude')
   @R_VA_CaidExcessGenExclude.operation = "
   RateGeneralExclusion = WebCalc.find_by_name('RateGeneralExclusion')
   RateGeneralExclusion = Float(RateGeneralExclusion.calculate manager)
   R_VA_CaidCountUnearnNoNeedIncomeAmt = WebCalc.find_by_name('R_VA_CaidCountUnearnNoNeedIncomeAmt')
   R_VA_CaidCountUnearnNoNeedIncomeAmt = Float(R_VA_CaidCountUnearnNoNeedIncomeAmt.calculate manager)
   if RateGeneralExclusion > R_VA_CaidCountUnearnNoNeedIncomeAmt then
     RateGeneralExclusion - R_VA_CaidCountUnearnNoNeedIncomeAmt
    else
      0
   end
   "
   @R_VA_CaidExcessGenExclude.save!


  #1240	Countable earned income before dividing by 2 (can't be < 0)	R_VA_CaidCountEarnAmtNoDivide
  #=MAX(0;E120-(E122+E124+MAX(E126, E128)))  Bob edit, workbook later 
 #  E120 R_VA_CaidEarnAmt
 #  E122 R_VA_CaidExcessGenExclude
 #  E124 RateEarnedIncDisregardAmt
 #  E126 SsiCaidIrweAmt
 #  E128 SgaIrweAmt
 
    @R_VA_CaidCountEarnAmtNoDivide  = WebCalc.new(:name => 'R_VA_CaidCountEarnAmtNoDivide')
    @R_VA_CaidCountEarnAmtNoDivide.operation = "
    R_VA_CaidEarnAmt = WebCalc.find_by_name('R_VA_CaidEarnAmt')
    R_VA_CaidEarnAmt = Float(R_VA_CaidEarnAmt.calculate manager)
    R_VA_CaidExcessGenExclude = WebCalc.find_by_name('R_VA_CaidExcessGenExclude')
    R_VA_CaidExcessGenExclude = Float(R_VA_CaidExcessGenExclude.calculate manager)
    RateEarnedIncDisregardAmt = WebCalc.find_by_name('RateEarnedIncomeDisregard')
    RateEarnedIncDisregardAmt = Float(RateEarnedIncDisregardAmt.calculate manager)
    SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
    SgaIrweAmt = manager.get_answer_by_question_name('SgaIrweAmt')
  [(R_VA_CaidEarnAmt - (R_VA_CaidExcessGenExclude + RateEarnedIncDisregardAmt + [SsiCaidIrweAmt.to_f, SgaIrweAmt.to_f].max)), 0].max
    "
    @R_VA_CaidCountEarnAmtNoDivide.save!
  
  end

  def self.down
  end
end
