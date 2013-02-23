class CreateRvaCaidSpouseCountIncomeAmtNoPassWebcalc < ActiveRecord::Migration
  def self.up
       require 'wwweb_session_manager'  

     #  1870	Spouse's Total Countable Income before PASS	R_VA_CaidSpouseCountIncomeAmtNoPASS
     #=E191+E193
     
     @R_VA_CaidSpouseCountIncomeAmtNoPASS = WebCalc.find_by_name('R_VA_CaidSpouseCountIncomeAmtNoPASS')
     if @R_VA_CaidSpouseCountIncomeAmtNoPASS.blank? then
       @R_VA_CaidSpouseCountIncomeAmtNoPASS  = WebCalc.new(:name => 'R_VA_CaidSpouseCountIncomeAmtNoPASS')
     end

     #  1870	Spouse's Total Countable Income before PASS	R_VA_CaidSpouseCountIncomeAmtNoPASS
      #=E191+E193
      #e191 R_VA_CaidSpouseCountUnearnAmt
      #e193 R_VA_CaidSpouseCountEarnAmt
   
     @R_VA_CaidSpouseCountIncomeAmtNoPASS  = WebCalc.new(:name => 'R_VA_CaidSpouseCountIncomeAmtNoPASS')
     @R_VA_CaidSpouseCountIncomeAmtNoPASS.operation = "
    R_VA_CaidSpouseCountUnearnAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnAmt')
    R_VA_CaidSpouseCountUnearnAmt = Float(R_VA_CaidSpouseCountUnearnAmt.calculate manager)
    R_VA_CaidSpouseCountEarnAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmt')
    R_VA_CaidSpouseCountEarnAmt = Float(R_VA_CaidSpouseCountEarnAmt.calculate manager)
    R_VA_CaidSpouseCountUnearnAmt + R_VA_CaidSpouseCountEarnAmt
      "
     @R_VA_CaidSpouseCountIncomeAmtNoPASS.save!
  end

  def self.down
  end
end
