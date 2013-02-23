class UpdateQuestionSpouseSsiCaidIrweAmtForInsert < ActiveRecord::Migration
  def self.up
    
      require 'wwweb_session_manager'  
         #25	148	How much of your spouse's $SpouseDisWorkExpAmt of disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?	
         #SpouseSsiCaidIrweAmt			Zero or Positive Number  =< SpouseDisWorkExpAmt	You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses (SpouseDisWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: SpouseDisWorkExpAmt	If SpouseSsiGet = Y AND SpouseDisWorkExpAmt > 0 AND (SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0 AND SpouseBlind = NO	Appear	400.00		154.00
         
        #SpouseSsiCaidIrweAmt question edit to add insert marker
        @SpouseSsiCaidIrweAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSsiCaidIrweAmt']) 
        @SpouseSsiCaidIrweAmt.update_attribute(:text, "How much of your spouse's ~ of disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?") 

       # calc to insert
       @RSpouseDisWorkExpAmt  = WebCalc.find_by_name('RSpouseDisWorkExpAmt')

       @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSsiCaidIrweAmt.id, 1])
       if @Insert2.blank? then
          @Insert2  = QuestionInsert.new(:question_id => @SpouseSsiCaidIrweAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseDisWorkExpAmt.id, :insert_marker => "~", :insert_type => 'currency')
          @Insert2.save!
      else
        @Insert2.update_attribute(:question_id, @SpouseSsiCaidIrweAmt.id)
        @Insert2.update_attribute(:insert_number, '1')
        @Insert2.update_attribute(:webcalc_id_to_insert, @RSpouseDisWorkExpAmt.id)
        @Insert2.update_attribute(:insert_marker, '~')
        @Insert2.update_attribute(:insert_type, 'currency')
       end
  end

  def self.down
  end
end
