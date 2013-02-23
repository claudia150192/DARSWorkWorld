class CreateRvaCaidSpouseEarnAmtWebcalc < ActiveRecord::Migration
  def self.up
 
     require 'wwweb_session_manager'  

     #720	Spouse's Earned Income	R_VA_CaidSpouseEarnAmt
     # SpouseSsiOrCaidEarnAmt
 
    @R_VA_CaidSpouseEarnAmt  = WebCalc.new(:name => 'R_VA_CaidSpouseEarnAmt')
    @R_VA_CaidSpouseEarnAmt.operation = "
   SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
   SpouseSsiOrCaidEarnAmt.to_f
  "
   @R_VA_CaidSpouseEarnAmt.save!

  end

  def self.down
  end
end
