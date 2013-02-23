class CreateRvaCaidCoupleGrossIncomeAmtWebcalc < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

      #970	Spouse's Gross Income	R_VA_CaidCoupleGrossIncomeAmt
      #=SUM(E93:E96)
      #e94 R_VA_CaidCoupleUnearnAmt
      #e95 R_VA_CaidCoupleEarnAmt
      @R_VA_CaidCoupleGrossIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidCoupleGrossIncomeAmt')
      @R_VA_CaidCoupleGrossIncomeAmt.operation = "
     R_VA_CaidCoupleUnearnAmt = WebCalc.find_by_name('R_VA_CaidCoupleUnearnAmt')
     R_VA_CaidCoupleUnearnAmt = Float(R_VA_CaidCoupleUnearnAmt.calculate manager)
     R_VA_CaidCoupleEarnAmt = WebCalc.find_by_name('R_VA_CaidCoupleEarnAmt')
     R_VA_CaidCoupleEarnAmt = Float(R_VA_CaidCoupleEarnAmt.calculate manager)
     R_VA_CaidCoupleUnearnAmt + R_VA_CaidCoupleEarnAmt
    "
         @R_VA_CaidCoupleGrossIncomeAmt.save!
  end

  def self.down
  end
end
