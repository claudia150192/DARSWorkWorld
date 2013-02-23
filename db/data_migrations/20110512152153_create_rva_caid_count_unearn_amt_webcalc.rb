class CreateRvaCaidCountUnearnAmtWebcalc < ActiveRecord::Migration
  def self.up
    #NOTE Bob went back and edited this one after migration and then made the change manually on local system

       require 'wwweb_session_manager'  

     #1054	Individual's Countable Unearned Income to be used in calculating Medicaid income eligibility (Can't be < 0)	R_VA_CaidCountUnearnAmt
     #R_VA_CaidCountUnearnNoNeedIncomeAmt Add Back In UnearnIncomeBasedOnNeedAmt yields R_VA_CaidCountUnearnAmt
           
      @R_VA_CaidCountUnearnAmt  = WebCalc.new(:name => 'R_VA_CaidCountUnearnAmt')
      @R_VA_CaidCountUnearnAmt.operation = "
     R_VA_CaidCountUnearnNoNeedIncomeAmt = WebCalc.find_by_name('R_VA_CaidCountUnearnNoNeedIncomeAmt')
     R_VA_CaidCountUnearnNoNeedIncomeAmt = Float(R_VA_CaidCountUnearnNoNeedIncomeAmt.calculate manager)
     UnearnIncomeBasedOnNeedAmt = manager.get_answer_by_question_name('UnearnIncomeBasedOnNeedAmt')
   (R_VA_CaidCountUnearnNoNeedIncomeAmt + UnearnIncomeBasedOnNeedAmt.to_f )
   "
         @R_VA_CaidCountUnearnAmt.save!
       
  end

  def self.down
  end
end
