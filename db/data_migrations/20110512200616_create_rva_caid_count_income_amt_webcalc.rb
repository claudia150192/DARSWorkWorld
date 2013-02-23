class CreateRvaCaidCountIncomeAmtWebcalc < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

      #add fix here 
      @R_VA_CaidCountIncomeAmt = WebCalc.find_by_name('R_VA_CaidCountIncomeAmt')
         if @R_VA_CaidCountIncomeAmt.blank? then
           @R_VA_CaidCountIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidCountIncomeAmt')
         end

  #    1450	Individual's Total Countable Income (can't be < 0) 	R_VA_CaidCountIncomeAmt
  #=MAX(0;E143-E145)
  #E143 VA_CaidCountIncomeAmtNoPASS
  #e145 PassAmt
  
  @R_VA_CaidCountIncomeAmt.operation = "
  VA_CaidCountIncomeAmtNoPASS = WebCalc.find_by_name('VA_CaidCountIncomeAmtNoPASS')
  VA_CaidCountIncomeAmtNoPASS = Float(VA_CaidCountIncomeAmtNoPASS.calculate manager)
  PassAmt = manager.get_answer_by_question_name('PassAmt')
  [(VA_CaidCountIncomeAmtNoPASS - PassAmt.to_f), 0].max
  "
  @R_VA_CaidCountIncomeAmt.save!
  end

  def self.down
  end
end
