class UpdateQuestionBweAmtForInsert < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
           #26	152	How much of your $DisWorkExpAmt of disability-related work expenses and $OthWorkExpAmt of other work expenses are counted as BWE?	
           #BweAmt			Zero or Positive Number  =<  DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt	You can not enter a BWE greater than the sum of your work expenses (DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt	If (Blind = Y AND (SsiGet = Y OR CaidGet = Y) AND (EXPRESSION: DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt) > 0 AND (SsiOrCaidEarnAmt - SeieAmt) > 0)	no			158.00
           
          #BweAmt question edit to add insert marker
          @BweAmt = Question.find(:first, :conditions => ['name = ?',  'BweAmt']) 
          @BweAmt.update_attribute(:text, "How much of your ~ of disability-related work expenses and ~ of other work expenses are counted as BWE?") 

         # 1 calc to insert
         @RDisWorkExpAmt  = WebCalc.find_by_name('RDisWorkExpAmt')

         @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @BweAmt.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionInsert.new(:question_id => @BweAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RDisWorkExpAmt.id, :insert_marker => "~", :insert_type => 'currency')
            @Insert1.save!
        else
          @Insert2.update_attribute(:question_id, @BweAmt.id)
          @Insert2.update_attribute(:insert_number, '1')
          @Insert2.update_attribute(:webcalc_id_to_insert, @RDisWorkExpAmt.id)
          @Insert2.update_attribute(:insert_marker, '~')
          @Insert2.update_attribute(:insert_type, 'currency')
         end
         
         # 2 calc to insert
          @ROthWorkExpAmt  = WebCalc.find_by_name('ROthWorkExpAmt')

          @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @BweAmt.id, 2])
          if @Insert2.blank? then
             @Insert2  = QuestionInsert.new(:question_id => @BweAmt.id, :insert_number => '2', :webcalc_id_to_insert => @ROthWorkExpAmt.id, :insert_marker => "~", :insert_type => 'currency')
             @Insert2.save!
         else
           @Insert2.update_attribute(:question_id, @BweAmt.id)
           @Insert2.update_attribute(:insert_number, '2')
           @Insert2.update_attribute(:webcalc_id_to_insert, @ROthWorkExpAmt.id)
           @Insert2.update_attribute(:insert_marker, '~')
           @Insert2.update_attribute(:insert_type, 'currency')
          end
  end

  def self.down
  end
end
