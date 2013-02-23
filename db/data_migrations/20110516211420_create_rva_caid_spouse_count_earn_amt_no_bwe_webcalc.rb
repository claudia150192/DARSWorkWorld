class CreateRvaCaidSpouseCountEarnAmtNoBweWebcalc < ActiveRecord::Migration
  def self.up
   
    require 'wwweb_session_manager' 
    # 1740	Countable earned income before BWE 	R_VA_CaidSpouseCountEarnAmtNoBWE

   @R_VA_CaidSpouseCountEarnAmtNoBWE = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmtNoBWE')
   if @R_VA_CaidSpouseCountEarnAmtNoBWE.blank? then
      @R_VA_CaidSpouseCountEarnAmtNoBWE  = WebCalc.new(:name => 'R_VA_CaidSpouseCountEarnAmtNoBWE')
   end
   #1740 =E182/2
   #e182 R_VA_CaidSpouseCountEarnAmtNoDivide
     
   
    @R_VA_CaidSpouseCountEarnAmtNoBWE.operation = "
    R_VA_CaidSpouseCountEarnAmtNoDivide = WebCalc.find_by_name('R_VA_CaidSpouseCountEarnAmtNoDivide')
    R_VA_CaidSpouseCountEarnAmtNoDivide = Float(R_VA_CaidSpouseCountEarnAmtNoDivide.calculate manager)
    R_VA_CaidSpouseCountEarnAmtNoDivide/2
     "
     @R_VA_CaidSpouseCountEarnAmtNoBWE.save!
  end

  def self.down
  end
end
