class CreateRvaCaidCoupleEarnAmtWebcalc < ActiveRecord::Migration
  def self.up

    require 'wwweb_session_manager'  

    #850	Couple's Earned Income	R_VA_CaidCoupleEarnAmt
    #=SUM(E82:E84)
    #R_VA_CaidEarnAmt
    #R_VA_CaidSpouseEarnAmt
 
      @R_VA_CaidCoupleEarnAmt  = WebCalc.new(:name => 'R_VA_CaidCoupleEarnAmt')
      @R_VA_CaidCoupleEarnAmt.operation = "
     R_VA_CaidEarnAmt = WebCalc.find_by_name('R_VA_CaidEarnAmt')
     R_VA_CaidEarnAmt = Float(R_VA_CaidEarnAmt.calculate manager)
     R_VA_CaidSpouseEarnAmt = WebCalc.find_by_name('R_VA_CaidSpouseEarnAmt')
     R_VA_CaidSpouseEarnAmt = Float(R_VA_CaidSpouseEarnAmt.calculate manager)
     R_VA_CaidEarnAmt + R_VA_CaidSpouseEarnAmt
    "
       @R_VA_CaidCoupleEarnAmt.save!
  end

  def self.down
  end
end
