class CreateRrvaCaidUnearnAmtWebcalc < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

         #430	Individual's Unearned Income	R_VA_CaidUnearnAmt
         #=E37+E42
       #  E37  R_VA_CaidUnearnNoDeemAmt
       #  e42  R_VA_CaidDeemedAmt
       
      @R_VA_CaidUnearnAmt  = WebCalc.new(:name => 'R_VA_CaidUnearnAmt')
      @R_VA_CaidUnearnAmt.operation = "
     R_VA_CaidUnearnNoDeemAmt = WebCalc.find_by_name('R_VA_CaidUnearnNoDeemAmt')
     R_VA_CaidUnearnNoDeemAmt = Float(R_VA_CaidUnearnNoDeemAmt.calculate manager)
     R_VA_CaidDeemedAmt = WebCalc.find_by_name('R_VA_CaidDeemedAmt')
     R_VA_CaidDeemedAmt = Float(R_VA_CaidDeemedAmt.calculate manager)
     R_VA_CaidUnearnNoDeemAmt + R_VA_CaidDeemedAmt
    "
       @R_VA_CaidUnearnAmt.save!

  end

  def self.down
  end
end
