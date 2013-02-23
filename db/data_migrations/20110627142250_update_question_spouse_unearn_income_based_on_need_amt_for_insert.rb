class UpdateQuestionSpouseUnearnIncomeBasedOnNeedAmtForInsert < ActiveRecord::Migration
  def self.up
      require 'wwweb_session_manager'  
       # 25	99	How much of your spouse's ~$SpouseUnEarnAmt~ of unearned income would SSA define as INCOME Based On Need?	SpouseUnearnIncomeBasedOnNeedAmt			Zero or Positive Number <= SpouseUnEarnAmt	You can not enter an amount higher than your spouse's unearned income, not counting SSDI or SSI (SpouseUnEarnAmt).  Enter positive numbers only.  Do not enter $.	0	IF SpouseUnEarnAmt > 0	no	90.00	A needs-based payment funded wholly or partially by a nongovernmental organization or by the Federal Government is called "income based on need" and does not qualify for this $20 general exclusion.	104.00
       
      #SpouseUnearnIncomeBasedOnNeedAmt question edit to add insert marker
      @SpouseUnearnIncomeBasedOnNeedAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseUnearnIncomeBasedOnNeedAmt']) 
       @SpouseUnearnIncomeBasedOnNeedAmt.update_attribute(:text, "How much of your spouse's ~ of unearned income would SSA define as INCOME Based On Need?") 

     # calc to insert
     @RSpouseUnEarnAmt  = WebCalc.find_by_name('RSpouseUnEarnAmt')

     @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseUnearnIncomeBasedOnNeedAmt.id, 1])
     if @Insert2.blank? then
        @Insert2  = QuestionInsert.new(:question_id => @SpouseUnearnIncomeBasedOnNeedAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseUnEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:question_id, @SpouseUnearnIncomeBasedOnNeedAmt.id)
      @Insert2.update_attribute(:insert_number, '1')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RSpouseUnEarnAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
  end

  def self.down
  end
end
