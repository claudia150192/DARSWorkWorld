class CreateRvaCaidCoupleCountEarnAmtWebcalc < ActiveRecord::Migration
  def self.up
   
    require 'wwweb_session_manager'  

     @R_VA_CaidCoupleCountEarnAmt = WebCalc.find_by_name('R_VA_CaidCoupleCountEarnAmt')
        if @R_VA_CaidCoupleCountEarnAmt.blank? then
          @R_VA_CaidCoupleCountEarnAmt  = WebCalc.new(:name => 'R_VA_CaidCoupleCountEarnAmt')
        end

     # #2060	Couple's Countable Earned Income	R_VA_CaidCoupleCountEarnAmt
     #=E210+E212
     #e210 R_VA_CaidCountEarnAmt
     #e212 R_VA_CaidSpouseCountEarnAmt
     
     @R_VA_CaidCoupleCountEarnAmt.operation = "
     R_VA_CaidCountEarnAmt = WebCalc.find_by_name('R_VA_CaidCountEarnAmt')
     R_VA_CaidCountEarnAmt = Float(R_VA_CaidCountEarnAmt.calculate manager)
     R_VA_CaidSpouseCountEarnAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmt')
     R_VA_CaidSpouseCountEarnAmt = Float(R_VA_CaidSpouseCountEarnAmt.calculate manager)
    (R_VA_CaidCountEarnAmt + R_VA_CaidSpouseCountEarnAmt)
      "
      @R_VA_CaidCoupleCountEarnAmt.save!
  end

  def self.down
  end
end
