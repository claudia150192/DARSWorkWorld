class UpdateQuestionSpouseSgaIrweAmtForValidation < ActiveRecord::Migration
  def self.up
    #25	150	How much of your spouse's $SpouseDisWorkExpAmt of disability-related work expenses are counted as IRWE to determine if earnings exceed SGA?	
    #SpouseSgaIrweAmt			Zero or Positive Number  <= SpouseDisWorkExpAmt	You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses (SpouseDisWorkExpAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: SpouseDisWorkExpAmt	IF(SpouseDisWorkExpAmt > 0) AND ((SpouseBlind = N AND SpouseSsdiEarnAmt > RateSgaDisabledAmt) OR (SpouseBlind = Y AND SpouseSsdiEarnAmt > RateSgaBlindAmt))	no			156.00
    
        require 'wwweb_session_manager'  
           
          #SpouseSgaIrweAmt question edit to add insert marker
          @SpouseSgaIrweAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSgaIrweAmt']) 

          @SpouseSgaIrweAmt.update_attribute(:validation_message, "You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses (~).  Enter positive numbers only.  Do not enter $.") unless @SpouseSgaIrweAmt.blank?

          # calc to insert
           @RSpouseDisWorkExpAmt  = WebCalc.find_by_name('RSpouseDisWorkExpAmt')

           @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSgaIrweAmt.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionValidationInsert.new(:question_id => @SpouseSgaIrweAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseDisWorkExpAmt.id, :insert_marker => "~", :insert_type => 'currency')
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @SpouseSgaIrweAmt.id)
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RSpouseDisWorkExpAmt.id)
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end

  end

  def self.down
  end
end
