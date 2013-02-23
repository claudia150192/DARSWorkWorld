class UpdateQuestionSgaIrweAmtForInsert < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
           #25	149	How much of your $DisWorkExpAmt of disability-related work expenses are counted as IRWE to determine if your earnings exceed SGA?	
           #SgaIrweAmt			Zero or Positive Number  <= DisWorkExpAmt	You can not enter an IRWE greater than the amount of your disability-related work expenses (DisWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: DisWorkExpAmt	IF(DisWorkExpAmt > 0) AND ((Blind = N AND SsdiEarnAmt > RateSgaDisabledAmt) OR (Blind = N AND SsiGetFinalDetermination = N AND SsiOrCaidEarnAmt > RateSgaDisabledAmt) OR (Blind = Y AND SsdiEarnAmt > RateSgaBlindAmt))	Appear	500.00		155.00
           
          #SgaIrweAmt question edit to add insert marker
          @SgaIrweAmt = Question.find(:first, :conditions => ['name = ?',  'SgaIrweAmt']) 
          @SgaIrweAmt.update_attribute(:text, "How much of your ~ of disability-related work expenses are counted as IRWE to determine if your earnings exceed SGA?") 

         # calc to insert
         @RDisWorkExpAmt  = WebCalc.find_by_name('RDisWorkExpAmt')

         @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SgaIrweAmt.id, 1])
         if @Insert2.blank? then
            @Insert2  = QuestionInsert.new(:question_id => @SgaIrweAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RDisWorkExpAmt.id, :insert_marker => "~", :insert_type => 'currency')
            @Insert2.save!
        else
          @Insert2.update_attribute(:question_id, @SgaIrweAmt.id)
          @Insert2.update_attribute(:insert_number, '1')
          @Insert2.update_attribute(:webcalc_id_to_insert, @RDisWorkExpAmt.id)
          @Insert2.update_attribute(:insert_marker, '~')
          @Insert2.update_attribute(:insert_type, 'currency')
         end
    
  end

  def self.down
  end
end
