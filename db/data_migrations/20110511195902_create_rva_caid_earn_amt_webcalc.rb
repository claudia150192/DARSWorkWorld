class CreateRvaCaidEarnAmtWebcalc < ActiveRecord::Migration
  def self.up
         require 'wwweb_session_manager'  

  #490	Individual's Gross Earned Income	R_VA_CaidEarnAmt
  #=SUM(E46:E49)
  #46 blank 
  #47 SsiOrCaidEarnAmt
  #48 VA_CaidSpouseDeemEarnAmt
  #49 blank {this is a known pattern of workbook containing row above and below what needs to be summed} 
     @R_VA_CaidEarnAmt  = WebCalc.new(:name => 'R_VA_CaidEarnAmt')
     @R_VA_CaidEarnAmt.operation = "
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    VA_CaidSpouseDeemEarnAmt = manager.get_answer_by_question_name('VA_CaidSpouseDeemEarnAmt') 
    SsiOrCaidEarnAmt.to_f + VA_CaidSpouseDeemEarnAmt.to_f
   "
   @R_VA_CaidEarnAmt.save!

  end

  def self.down
  end
end
