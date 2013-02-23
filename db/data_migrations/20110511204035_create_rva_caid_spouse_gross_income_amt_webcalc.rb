class CreateRvaCaidSpouseGrossIncomeAmtWebcalc < ActiveRecord::Migration
  def self.up
         require 'wwweb_session_manager'  

  #780	Spouse's Gross Income	R_VA_CaidSpouseGrossIncomeAmt
  #=SUM(E74:E77)
  #E75 R_VA_CaidSpouseUnearnAmt
  #E76 R_VA_CaidSpouseEarnAmt
         

    @R_VA_CaidSpouseGrossIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidSpouseGrossIncomeAmt')
    @R_VA_CaidSpouseGrossIncomeAmt.operation = "
   R_VA_CaidSpouseUnearnAmt = WebCalc.find_by_name('R_VA_CaidSpouseUnearnAmt')
   R_VA_CaidSpouseUnearnAmt = Float(R_VA_CaidSpouseUnearnAmt.calculate manager)
   R_VA_CaidSpouseEarnAmt = WebCalc.find_by_name('R_VA_CaidSpouseEarnAmt')
   R_VA_CaidSpouseEarnAmt = Float(R_VA_CaidSpouseEarnAmt.calculate manager)
   R_VA_CaidSpouseUnearnAmt + R_VA_CaidSpouseEarnAmt
  "
     @R_VA_CaidSpouseGrossIncomeAmt.save!    
  end

  def self.down
  end
end
