class UpdateQuestionSpouseUnearnInfrequentAmtForInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
     # 25	98	How much of your spouse's ~$SpouseUnEarnAmt~ of unearned income does your spouse receive infrequently or irregularly?	SpouseUnearnInfrequentAmt		
     #	Zero or Positive Number	Enter positive numbers only.  Do not enter $.	0	IF SpouseUnEarnAmt > 0	no	20.00	TIP NEEDED:  FOR MEDICAID PURPOSES, IF USER + SPOUSE'S INFREQ OR IRREG UNEARNED INCOME > $20, IT CANNOT BE EXCLUDED.   (See M0810.410)	103.00
 
    #SpouseUnearnInfrequentAmt question edit to add insert marker
    @SpouseUnearnInfrequentAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseUnearnInfrequentAmt']) 
     @SpouseUnearnInfrequentAmt.update_attribute(:text, "How much of your spouse's ~ of unearned income does your spouse receive infrequently or irregularly?") 

   # calc to insert
   @RSpouseUnEarnAmt  = WebCalc.find_by_name('RSpouseUnEarnAmt')

   @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseUnearnInfrequentAmt.id, 1])
   if @Insert2.blank? then
      @Insert2  = QuestionInsert.new(:question_id => @SpouseUnearnInfrequentAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseUnEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
      @Insert2.save!
  else
    @Insert2.update_attribute(:question_id, @SpouseUnearnInfrequentAmt.id)
    @Insert2.update_attribute(:insert_number, '1')
    @Insert2.update_attribute(:webcalc_id_to_insert, @RSpouseUnEarnAmt.id)
    @Insert2.update_attribute(:insert_marker, '~')
    @Insert2.update_attribute(:insert_type, 'currency')
   end
  end

  def self.down
  end
end
