class CreateRvaCaidSpouseUnearnAmtWebcalc < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

         #660	Spouse's Unearned Income	R_VA_CaidSpouseUnearnAmt
         
         #=SUM(E60:E66)
       # E61 R_SpouseSsdiPayNoAdjustAmt
       # SpouseSsdiWcOrPdbDecreaseAmt   subtract
       # SpouseSsdiUnderPayIncreaseAmt
       # SpouseSsdiOverPayDecreaseAmt   subtract
       # SpouseUnEarnAmt
  
      @R_VA_CaidSpouseUnearnAmt  = WebCalc.new(:name => 'R_VA_CaidSpouseUnearnAmt')
      @R_VA_CaidSpouseUnearnAmt.operation = "
     R_SpouseSsdiPayNoAdjustAmt = WebCalc.find_by_name('R_SpouseSsdiPayNoAdjustAmt')
     R_SpouseSsdiPayNoAdjustAmt = Float(R_SpouseSsdiPayNoAdjustAmt.calculate manager)
     SpouseSsdiWcOrPdbDecreaseAmt = manager.get_answer_by_question_name('SpouseSsdiWcOrPdbDecreaseAmt')
     SpouseSsdiUnderPayIncreaseAmt = manager.get_answer_by_question_name('SpouseSsdiUnderPayIncreaseAmt')
     SpouseSsdiOverPayDecreaseAmt = manager.get_answer_by_question_name('SpouseSsdiOverPayDecreaseAmt')
     SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt') 
     R_SpouseSsdiPayNoAdjustAmt + SpouseSsdiUnderPayIncreaseAmt.to_f + SpouseUnEarnAmt.to_f - SpouseSsdiWcOrPdbDecreaseAmt.to_f - SpouseSsdiOverPayDecreaseAmt.to_f
    "
       @R_VA_CaidSpouseUnearnAmt.save!

  end

  def self.down
  end
end
