class CreateRvaCaidCoupleCountUnearnAmtWebcalc < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'  

     @R_VA_CaidCoupleCountUnearnAmt = WebCalc.find_by_name('R_VA_CaidCoupleCountUnearnAmt')
        if @R_VA_CaidCoupleCountUnearnAmt.blank? then
          @R_VA_CaidCoupleCountUnearnAmt  = WebCalc.new(:name => 'R_VA_CaidCoupleCountUnearnAmt')
        end

     #   1990	Couple's Countable Unearned Income	R_VA_CaidCoupleCountUnearnAmt
     #=E203+E205
     #e203 R_VA_CaidCountUnearnAmt
     #e205 R_VA_CaidSpouseCountUnearnAmt
     

     @R_VA_CaidCoupleCountUnearnAmt.operation = "
     R_VA_CaidCountUnearnAmt = WebCalc.find_by_name('R_VA_CaidCountUnearnAmt')
     R_VA_CaidCountUnearnAmt = Float(R_VA_CaidCountUnearnAmt.calculate manager)
     R_VA_CaidSpouseCountUnearnAmt = WebCalc.find_by_name('R_VA_CaidSpouseCountUnearnAmt')
     R_VA_CaidSpouseCountUnearnAmt = Float(R_VA_CaidSpouseCountUnearnAmt.calculate manager)
    (R_VA_CaidCountUnearnAmt + R_VA_CaidSpouseCountUnearnAmt)
      "
      @R_VA_CaidCoupleCountUnearnAmt.save!
  end

  def self.down
  end
end
