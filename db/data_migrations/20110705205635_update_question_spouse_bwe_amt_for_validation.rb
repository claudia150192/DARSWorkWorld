class UpdateQuestionSpouseBweAmtForValidation < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
          #26	153	How much of your spouse's $SpouseDisWorkExpAmt of disability-related work expenses and $SpouseOthWorkExpAmt of other work expenses are counted as BWE?	
          #SpouseBweAmt			Zero or Positive Number  =<  SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt	You can not enter a BWE greater than the sum of your spouse's work expenses (SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt	 (SpouseBlind = Y AND (SpouseSsiGet = Y OR CaidSpouseGet) AND ( SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt) > 0 AND (SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0)	no			159.00
          
          #SpouseBweAmt question edit to add insert marker
          @SpouseBweAmt = Question.find(:first, :conditions => ['name = ?', 'SpouseBweAmt']) 

          @SpouseBweAmt.update_attribute(:validation_message, "You can not enter a BWE greater than the sum of your spouse's work expenses (~).  Enter positive numbers only.  Do not enter $.") unless @SpouseBweAmt.blank?

          # calc to insert
           @RSpouseBweWorkExpenseTotal  = WebCalc.find_by_name('RSpouseBweWorkExpenseTotal')

           @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseBweAmt.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionValidationInsert.new(:question_id => @SpouseBweAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseBweWorkExpenseTotal.id, :insert_marker => "~", :insert_type => 'currency')
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @SpouseBweAmt.id)
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RSpouseBweWorkExpenseTotal.id)
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end

  end

  def self.down
  end
end
