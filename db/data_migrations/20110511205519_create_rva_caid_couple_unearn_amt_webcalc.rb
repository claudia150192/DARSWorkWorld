class CreateRvaCaidCoupleUnearnAmtWebcalc < ActiveRecord::Migration
  def self.up

    require 'wwweb_session_manager'  

    #910	Couple's Unearned Income	R_VA_CaidCoupleUnearnAmt
    #=SUM(E87:E90)
    #e88 R_VA_CaidUnearnAmt
    #e89 R_VA_CaidSpouseUnearnAmt
     
    @R_VA_CaidCoupleUnearnAmt  = WebCalc.new(:name => 'R_VA_CaidCoupleUnearnAmt')
    @R_VA_CaidCoupleUnearnAmt.operation = "
   R_VA_CaidUnearnAmt = WebCalc.find_by_name('R_VA_CaidUnearnAmt')
   R_VA_CaidUnearnAmt = Float(R_VA_CaidUnearnAmt.calculate manager)
   R_VA_CaidSpouseUnearnAmt = WebCalc.find_by_name('R_VA_CaidSpouseUnearnAmt')
   R_VA_CaidSpouseUnearnAmt = Float(R_VA_CaidSpouseUnearnAmt.calculate manager)
   R_VA_CaidUnearnAmt + R_VA_CaidSpouseUnearnAmt
  "
       @R_VA_CaidCoupleUnearnAmt.save!
  end

  def self.down
  end
end
