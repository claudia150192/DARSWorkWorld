class CreateRvaCaidSpouseCountUnearnAmtWebcalc < ActiveRecord::Migration
  def self.up

   require 'wwweb_session_manager'  

   @R_VA_CaidSpouseCountUnearnAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnAmt ')
      if @R_VA_CaidSpouseCountUnearnAmt.blank? then
        @R_VA_CaidSpouseCountUnearnAmt  = WebCalc.new(:name => 'R_VA_CaidSpouseCountUnearnAmt ')
      end

   #1554	Individual's Countable Unearned Income to be used in calculating Medicaid income eligibility (Can't be < 0)	R_VA_CaidSpouseCountUnearnAmt
   #=E163+E165
   #163 R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt
   #165 SpouseUnearnAssistanceBasedOnNeedAmt
   
   @R_VA_CaidSpouseCountUnearnAmt.operation = "
    R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt')
    R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt = Float(R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt.calculate manager)
   SpouseUnearnAssistanceBasedOnNeedAmt = manager.get_answer_by_question_name('SpouseUnearnAssistanceBasedOnNeedAmt')
  (R_VA_CaidSpouseCountUnearnNoNeedIncomeAmt + SpouseUnearnAssistanceBasedOnNeedAmt.to_f)
    "
    @R_VA_CaidSpouseCountUnearnAmt.save!
  end

  def self.down
  end
end
