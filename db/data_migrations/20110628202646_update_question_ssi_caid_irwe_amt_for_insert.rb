class UpdateQuestionSsiCaidIrweAmtForInsert < ActiveRecord::Migration
  def self.up
    
      require 'wwweb_session_manager'  
         #25	147	How much of your $DisWorkExpAmt of disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?	
         #SsiCaidIrweAmt			Zero or Positive Number  =<  DisWorkExpAmt	You can not enter an IRWE greater than the amount of your disability-related work expenses (DisWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: DisWorkExpAmt	IF SsiGet = Y AND DisWorkExpAmt > 0 AND (SsiOrCaidEarnAmt - SeieAmt) > 0 AND Blind = N	no	500.00	I decided not to make the Allowable Answers take into account how much earned income there was that could be offset with IRWE.  The calcs will guard against answers < 0.	153.00

        #SsiCaidIrweAmt question edit to add insert marker
        @SsiCaidIrweAmt = Question.find(:first, :conditions => ['name = ?',  'SsiCaidIrweAmt']) 
        @SsiCaidIrweAmt.update_attribute(:text, "How much of your ~ of disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?") 

       # calc to insert
       @RDisWorkExpAmt  = WebCalc.find_by_name('RDisWorkExpAmt')

       @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SsiCaidIrweAmt.id, 1])
       if @Insert2.blank? then
          @Insert2  = QuestionInsert.new(:question_id => @SsiCaidIrweAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RDisWorkExpAmt.id, :insert_marker => "~", :insert_type => 'currency')
          @Insert2.save!
      else
        @Insert2.update_attribute(:question_id, @SsiCaidIrweAmt.id)
        @Insert2.update_attribute(:insert_number, '1')
        @Insert2.update_attribute(:webcalc_id_to_insert, @RDisWorkExpAmt.id)
        @Insert2.update_attribute(:insert_marker, '~')
        @Insert2.update_attribute(:insert_type, 'currency')
       end
  end

  def self.down
  end
end
