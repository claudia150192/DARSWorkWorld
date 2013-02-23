class CreateRvaCaidGrossIncomeAmtWebcalc < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

      #560	Individual's Gross Income	R_VA_CaidGrossIncomeAmt
      #=SUM(E52:E56)
      #E53 R_VA_CaidUnearnAmt
      #E55 R_VA_CaidEarnAmt
          
   @R_VA_CaidGrossIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidGrossIncomeAmt')
   @R_VA_CaidGrossIncomeAmt.operation = "
  R_VA_CaidUnearnAmt = WebCalc.find_by_name('R_VA_CaidUnearnAmt')
  R_VA_CaidUnearnAmt = Float(R_VA_CaidUnearnAmt.calculate manager)
  R_VA_CaidEarnAmt = WebCalc.find_by_name('R_VA_CaidEarnAmt')
  R_VA_CaidEarnAmt = Float(R_VA_CaidEarnAmt.calculate manager)
  R_VA_CaidUnearnAmt + R_VA_CaidEarnAmt
 "
  @R_VA_CaidGrossIncomeAmt.save!
  end

  def self.down
  end
end
