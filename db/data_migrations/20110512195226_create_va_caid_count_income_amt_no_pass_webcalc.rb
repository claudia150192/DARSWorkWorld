class CreateVaCaidCountIncomeAmtNoPassWebcalc < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

   #   1410	Individual's Total Countable Income before PASS	VA_CaidCountIncomeAmtNoPASS
   #=E139+E141
   #139 R_VA_CaidCountUnearnAmt
   #141 R_VA_CaidCountEarnAmt
   
   @VA_CaidCountIncomeAmtNoPASS  = WebCalc.new(:name => 'VA_CaidCountIncomeAmtNoPASS')
   @VA_CaidCountIncomeAmtNoPASS.operation = "
  R_VA_CaidCountUnearnAmt = WebCalc.find_by_name('R_VA_CaidCountUnearnAmt')
  R_VA_CaidCountUnearnAmt = Float(R_VA_CaidCountUnearnAmt.calculate manager)
  R_VA_CaidCountEarnAmt = WebCalc.find_by_name('R_VA_CaidCountEarnAmt')
  R_VA_CaidCountEarnAmt = Float(R_VA_CaidCountEarnAmt.calculate manager)
  R_VA_CaidCountUnearnAmt + R_VA_CaidCountEarnAmt
    "
   @VA_CaidCountIncomeAmtNoPASS.save!    
  end

  def self.down
  end
end
