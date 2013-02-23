class UpdateQuestionSpouseSgaIrweAmtForInsert < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  
         #25	150	How much of your spouse's $SpouseDisWorkExpAmt of disability-related work expenses are counted as IRWE to determine if earnings exceed SGA?	
         #SpouseSgaIrweAmt			Zero or Positive Number  <= SpouseDisWorkExpAmt	You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses (SpouseDisWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: SpouseDisWorkExpAmt	IF(SpouseDisWorkExpAmt > 0) AND ((SpouseBlind = N AND SpouseSsdiEarnAmt > RateSgaDisabledAmt) OR (SpouseBlind = Y AND SpouseSsdiEarnAmt > RateSgaBlindAmt))	no			156.00
         
        #SpouseSgaIrweAmt question edit to add insert marker
        @SpouseSgaIrweAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSgaIrweAmt']) 
        @SpouseSgaIrweAmt.update_attribute(:text, "How much of your spouse's ~ of disability-related work expenses are counted as IRWE to determine if earnings exceed SGA?") 

       # calc to insert
       @RSpouseDisWorkExpAmt  = WebCalc.find_by_name('RSpouseDisWorkExpAmt')

       @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSgaIrweAmt.id, 1])
       if @Insert2.blank? then
          @Insert2  = QuestionInsert.new(:question_id => @SpouseSgaIrweAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseDisWorkExpAmt.id, :insert_marker => "~", :insert_type => 'currency')
          @Insert2.save!
      else
        @Insert2.update_attribute(:question_id, @SpouseSgaIrweAmt.id)
        @Insert2.update_attribute(:insert_number, '1')
        @Insert2.update_attribute(:webcalc_id_to_insert, @RSpouseDisWorkExpAmt.id)
        @Insert2.update_attribute(:insert_marker, '~')
        @Insert2.update_attribute(:insert_type, 'currency')
       end
  end

  def self.down
  end
end
