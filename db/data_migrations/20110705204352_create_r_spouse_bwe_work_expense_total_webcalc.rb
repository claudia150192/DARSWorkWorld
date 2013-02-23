class CreateRSpouseBweWorkExpenseTotalWebcalc < ActiveRecord::Migration
  def self.up
        require 'wwweb_session_manager'  

    #     You can not enter a BWE greater than the sum of your spouse's work expenses (SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt).  Enter positive numbers only.  Do not enter $.

        @RSpouseBweWorkExpenseTotal = WebCalc.find_by_name('RSpouseBweWorkExpenseTotal')
        if @RSpouseBweWorkExpenseTotal.blank? then
           @RSpouseBweWorkExpenseTotal  = WebCalc.new(:name => 'RSpouseBweWorkExpenseTotal')
        end

        @RSpouseBweWorkExpenseTotal.operation = "
       SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
       SpouseEstEarnTaxAmt = manager.get_answer_by_question_name('SpouseEstEarnTaxAmt')
       SpouseOthWorkExpAmt = manager.get_answer_by_question_name('SpouseOthWorkExpAmt')
       SpouseDisWorkExpAmt.to_f + SpouseEstEarnTaxAmt.to_f + SpouseOthWorkExpAmt.to_f
       "
        @RSpouseBweWorkExpenseTotal.save!
  end

  def self.down
  end
end
