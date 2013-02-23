class CreateRvaCaidUnearnNoDeemAmtWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  

       #360	Individual's Unearned Income without considering deeming	R_VA_CaidUnearnNoDeemAmt
       #=SUM(E30:E36)
     #  E30 R_SsdiPayNoAdjustAmt
     #  SsdiWcOrPdbDecreaseAmt  needs to be subtracted
     #  SsdiUnderPayIncreaseAmt
     #  SsdiOverPayDecreaseAmt Needs to be subtracted
     #  UnearnAmt
 
    @R_VA_CaidUnearnNoDeemAmt  = WebCalc.new(:name => 'R_VA_CaidUnearnNoDeemAmt')
    @R_VA_CaidUnearnNoDeemAmt.operation = "
   R_SsdiPayNoAdjustAmt = WebCalc.find_by_name('R_SsdiPayNoAdjustAmt')
   R_SsdiPayNoAdjustAmt = Float(R_SsdiPayNoAdjustAmt.calculate manager)
   SsdiWcOrPdbDecreaseAmt = manager.get_answer_by_question_name('SsdiWcOrPdbDecreaseAmt')
   SsdiUnderPayIncreaseAmt = manager.get_answer_by_question_name('SsdiUnderPayIncreaseAmt')
   SsdiOverPayDecreaseAmt = manager.get_answer_by_question_name('SsdiOverPayDecreaseAmt')
   UnearnAmt = manager.get_answer_by_question_name('UnearnAmt') 
   R_SsdiPayNoAdjustAmt + SsdiUnderPayIncreaseAmt.to_f + UnearnAmt.to_f - SsdiWcOrPdbDecreaseAmt.to_f - SsdiOverPayDecreaseAmt.to_f
  "
     @R_VA_CaidUnearnNoDeemAmt.save!
  end

  def self.down
  end
end
