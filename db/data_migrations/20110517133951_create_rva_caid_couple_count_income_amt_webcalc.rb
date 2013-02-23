class CreateRvaCaidCoupleCountIncomeAmtWebcalc < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  

     @R_VA_CaidCoupleCountIncomeAmt = WebCalc.find_by_name('R_VA_CaidCoupleCountIncomeAmt')
        if @R_VA_CaidCoupleCountIncomeAmt.blank? then
          @R_VA_CaidCoupleCountIncomeAmt  = WebCalc.new(:name => 'R_VA_CaidCoupleCountIncomeAmt')
        end

     #2130	Couple's Countable Income (If not ABD couple, then this will be individual's income)	R_VA_CaidCoupleCountIncomeAmt
    # =E217+E219
    #e217 R_VA_CaidCoupleCountUnearnAmt
    #e219 R_VA_CaidCoupleCountEarnAmt
        
     @R_VA_CaidCoupleCountIncomeAmt.operation = "
     R_VA_CaidCoupleCountUnearnAmt = WebCalc.find_by_name('R_VA_CaidCoupleCountUnearnAmt')
     R_VA_CaidCoupleCountUnearnAmt = Float(R_VA_CaidCoupleCountUnearnAmt.calculate manager)
     R_VA_CaidCoupleCountEarnAmt = WebCalc.find_by_name('R_VA_CaidCoupleCountEarnAmt')
     R_VA_CaidCoupleCountEarnAmt = Float(R_VA_CaidCoupleCountEarnAmt.calculate manager)
    (R_VA_CaidCoupleCountUnearnAmt + R_VA_CaidCoupleCountEarnAmt)
      "
      @R_VA_CaidCoupleCountIncomeAmt.save!
  end

  def self.down
  end
end
