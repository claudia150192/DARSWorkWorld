class CreateRvaCaidDeemedAmtWebcalc < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  

 #     410	Individual's Resulting Deemed Income	R_VA_CaidDeemedAmt
 # =SUM(E38:E41)
 # E39 VA_CaidParDeemAmt
 # e40 VA_CaidSpouseDeemUnearnAmt
 
    @R_VA_CaidDeemedAmt  = WebCalc.new(:name => 'R_VA_CaidDeemedAmt')
    @R_VA_CaidDeemedAmt.operation = "
   VA_CaidParDeemAmt = manager.get_answer_by_question_name('VA_CaidParDeemAmt')
   VA_CaidSpouseDeemUnearnAmt = manager.get_answer_by_question_name('VA_CaidSpouseDeemUnearnAmt') 
   VA_CaidParDeemAmt.to_f + VA_CaidSpouseDeemUnearnAmt.to_f
  "
  @R_VA_CaidDeemedAmt.save!

  end

  def self.down
  end
end
