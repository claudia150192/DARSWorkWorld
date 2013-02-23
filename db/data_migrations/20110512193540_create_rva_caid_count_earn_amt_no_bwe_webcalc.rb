class CreateRvaCaidCountEarnAmtNoBweWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
     #1260	Countable earned income before BWE 	R_VA_CaidCountEarnAmtNoBWE
     #=E130/2
     #130 R_VA_CaidCountEarnAmtNoDivide
     
     @R_VA_CaidCountEarnAmtNoBWE  = WebCalc.new(:name => 'R_VA_CaidCountEarnAmtNoBWE')
     @R_VA_CaidCountEarnAmtNoBWE.operation = "
     R_VA_CaidCountEarnAmtNoDivide = WebCalc.find_by_name('R_VA_CaidCountEarnAmtNoDivide')
     R_VA_CaidCountEarnAmtNoDivide = Float(R_VA_CaidCountEarnAmtNoDivide.calculate manager)
     R_VA_CaidCountEarnAmtNoDivide/2
     "
     @R_VA_CaidCountEarnAmtNoBWE.save!
  end

  def self.down
  end
end
