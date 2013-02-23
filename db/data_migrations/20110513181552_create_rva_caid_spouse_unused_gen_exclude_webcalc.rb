class CreateRvaCaidSpouseUnusedGenExcludeWebcalc < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'  
    
    
     @R_VA_CaidSpouseUnusedGenExclude = WebCalc.find_by_name('R_VA_CaidSpouseUnusedGenExclude')
       if @R_VA_CaidSpouseUnusedGenExclude.blank? then
         @R_VA_CaidSpouseUnusedGenExclude  = WebCalc.new(:name => 'R_VA_CaidSpouseUnusedGenExclude')
       end
    
    #This needs to be redone 
   # 1580	Amount of General Exclusion to subtract from earned income	R_VA_CaidSpouseUnusedGenExclude
   # #=IF(E151>E153;E151-E153;0)
   #e151 R_VA_CaidSpouseExcessUserGenExclude
   #e153 R_VA_CaidSpouseUnearnAmt
   
    
     @R_VA_CaidSpouseUnusedGenExclude.operation = "
     R_VA_CaidSpouseExcessUserGenExclude = WebCalc.find_by_name('R_VA_CaidSpouseExcessUserGenExclude')
     R_VA_CaidSpouseExcessUserGenExclude = Float(R_VA_CaidSpouseExcessUserGenExclude.calculate manager)
     R_VA_CaidSpouseUnearnAmt = WebCalc.find_by_name('R_VA_CaidSpouseUnearnAmt')
     R_VA_CaidSpouseUnearnAmt = Float(R_VA_CaidSpouseUnearnAmt.calculate manager)
     if R_VA_CaidSpouseExcessUserGenExclude > R_VA_CaidSpouseUnearnAmt then
       R_VA_CaidSpouseExcessUserGenExclude - R_VA_CaidSpouseUnearnAmt
        else
          0
       end
       "
       @R_VA_CaidSpouseUnusedGenExclude.save!
  end

  def self.down
  end
end
