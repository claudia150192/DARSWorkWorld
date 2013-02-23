class CreateBweWorkExpenseTotalWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  

#    You can not enter a BWE greater than the sum of your work expenses (DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt).  Enter positive numbers only.  Do not enter $.
 
    @RBweWorkExpenseTotal = WebCalc.find_by_name('RBweWorkExpenseTotal')
    if @RBweWorkExpenseTotal.blank? then
       @RBweWorkExpenseTotal  = WebCalc.new(:name => 'RBweWorkExpenseTotal')
    end
 
    @RBweWorkExpenseTotal.operation = "
   DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
   EstEarnTaxAmt = manager.get_answer_by_question_name('EstEarnTaxAmt')
   OthWorkExpAmt = manager.get_answer_by_question_name('OthWorkExpAmt')
   DisWorkExpAmt.to_f + EstEarnTaxAmt.to_f + OthWorkExpAmt.to_f
   "
    @RBweWorkExpenseTotal.save!
  end

  def self.down
  end
end
