class CreateRvaCaidSpouseCountIncomeAmtWebcalc < ActiveRecord::Migration
  def self.up
       require 'wwweb_session_manager'  

     @R_VA_CaidSpouseCountIncomeAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountIncomeAmt')
     if @R_VA_CaidSpouseCountIncomeAmt.blank? then
       @R_VA_CaidSpouseCountIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidSpouseCountIncomeAmt')
     end

     #1910	Spouse's Total Countable Income (can't be < 0) 	R_VA_CaidSpouseCountIncomeAmt
     #=MAX(0;E195-E197)
     #e195 R_VA_CaidSpouseCountIncomeAmtNoPASS
     #e197 SpousePassAmt
     
    @R_VA_CaidSpouseCountIncomeAmt.operation = "
    R_VA_CaidSpouseCountIncomeAmtNoPASS = WebCalc.find_by_name('R_VA_CaidSpouseCountIncomeAmtNoPASS')
    R_VA_CaidSpouseCountIncomeAmtNoPASS = Float(R_VA_CaidSpouseCountIncomeAmtNoPASS.calculate manager)
    SpousePassAmt = manager.get_answer_by_question_name('SpousePassAmt')
    [(R_VA_CaidSpouseCountIncomeAmtNoPASS - SpousePassAmt.to_f), 0].max
    "
    @R_VA_CaidSpouseCountIncomeAmt.save!
  end

  def self.down
  end
end
