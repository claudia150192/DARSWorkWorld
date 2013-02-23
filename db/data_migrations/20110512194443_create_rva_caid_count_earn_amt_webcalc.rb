class CreateRvaCaidCountEarnAmtWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
 
    @R_VA_CaidCountEarnAmt = WebCalc.find_by_name('R_VA_CaidCountEarnAmt')
        if @R_VA_CaidCountEarnAmt.blank? then
          @R_VA_CaidCountEarnAmt  = WebCalc.new(:name => 'R_VA_CaidCountEarnAmt')
        end
 
   # 1340	Individual's Countable Earned Income (Can't be < 0)	R_VA_CaidCountEarnAmt
  #=MAX(0;E132-E134)
 #E132  R_VA_CaidCountEarnAmtNoBWE
 #e134 BweAmt
   @R_VA_CaidCountEarnAmt.operation = "
   R_VA_CaidCountEarnAmtNoBWE = WebCalc.find_by_name('R_VA_CaidCountEarnAmtNoBWE')
   R_VA_CaidCountEarnAmtNoBWE = Float(R_VA_CaidCountEarnAmtNoBWE.calculate manager)
   BweAmt = manager.get_answer_by_question_name('BweAmt')
   [(R_VA_CaidCountEarnAmtNoBWE - BweAmt.to_f), 0].max
   "
   @R_VA_CaidCountEarnAmt.save!
  end

  def self.down
  end
end
