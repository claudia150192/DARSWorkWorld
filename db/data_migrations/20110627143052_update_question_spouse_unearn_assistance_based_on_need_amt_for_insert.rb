class UpdateQuestionSpouseUnearnAssistanceBasedOnNeedAmtForInsert < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  
       #25	100	How much of your spouse's ~$SpouseUnEarnAmt~ of unearned income would SSA define as ASSISTANCE Based On Need?	SpouseUnearnAssistanceBasedOnNeedAmt			Zero or Positive Number <= SpouseUnEarnAmt	You can not enter an amount higher than your spouse's unearned income, not counting SSDI or SSI (SpouseUnEarnAmt).  Enter positive numbers only.  Do not enter $.	0	IF SpouseUnEarnAmt > 0	no	30.00	Assistance based on need and funded wholly by a State and/or one of its political subdivisions (including Indian tribes) is wholly excluded (not counted as unearned income).	105.00
          
      #SpouseUnearnAssistanceBasedOnNeedAmt question edit to add insert marker
      @SpouseUnearnAssistanceBasedOnNeedAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseUnearnAssistanceBasedOnNeedAmt']) 
       @SpouseUnearnAssistanceBasedOnNeedAmt.update_attribute(:text, "How much of your spouse's ~ of unearned income would SSA define as ASSISTANCE Based On Need?") 

     # calc to insert
     @RSpouseUnEarnAmt  = WebCalc.find_by_name('RSpouseUnEarnAmt')

     @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseUnearnAssistanceBasedOnNeedAmt.id, 1])
     if @Insert2.blank? then
        @Insert2  = QuestionInsert.new(:question_id => @SpouseUnearnAssistanceBasedOnNeedAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseUnEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:question_id, @SpouseUnearnAssistanceBasedOnNeedAmt.id)
      @Insert2.update_attribute(:insert_number, '1')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RSpouseUnEarnAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
  end

  def self.down
  end
end
