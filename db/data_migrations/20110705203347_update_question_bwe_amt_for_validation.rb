class UpdateQuestionBweAmtForValidation < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
           #26	152	How much of your $DisWorkExpAmt of disability-related work expenses and $OthWorkExpAmt of other work expenses are counted as BWE?	
           #BweAmt			Zero or Positive Number  =<  DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt	
           #You can not enter a BWE greater than the sum of your work expenses (DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt	If (Blind = Y AND (SsiGet = Y OR CaidGet = Y) AND (EXPRESSION: DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt) > 0 AND (SsiOrCaidEarnAmt - SeieAmt) > 0)	no			158.00
           
          #BweAmt question edit to add insert marker
          @BweAmt = Question.find(:first, :conditions => ['name = ?', 'BweAmt']) 

          @BweAmt.update_attribute(:validation_message, "You can not enter a BWE greater than the sum of your work expenses (~).  Enter positive numbers only.  Do not enter $.") unless @BweAmt.blank?

          # calc to insert
           @RBweWorkExpenseTotal  = WebCalc.find_by_name('RBweWorkExpenseTotal')

           @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @BweAmt.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionValidationInsert.new(:question_id => @BweAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RBweWorkExpenseTotal.id, :insert_marker => "~", :insert_type => 'currency')
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @BweAmt.id)
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RBweWorkExpenseTotal.id)
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end

  end

  def self.down
  end
end
