class UpdateInKindPmvAmtQuestionValidationInsertValue < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
         #26 47	86	PMV Rule: How much In-Kind Support are you considered by SSA to receive?  (Default is the Presumed Maximum Value or PMV.)	InKindPMVAmt			
         #IF SsiGet = Y AND SpouseSsiGet = Y, THEN Zero or Positive Number <= RatePmvCoupleAmt, ELSE <= RatePmvAmt	
         #You can not enter an amount higher than the Presumed Maximum Value (PMV) of ~RatePmvAmt~ for an individual or ~RatePmvCoupleAmt~ for a couple on SSI.  Enter positive numbers only.  Do not enter $.	EXPRESSION:  IF SpouseSsiGet = Y, THEN RatePmvCoupleAmt, ELSE RatePmvAmt	If InKindThird = N	no		This amount will be added to the user's unearned income. Allowable answer includes Couple PMV if user has spouse because that PMV could be used in spousal deeming.	91.00
         
        #InKindPMVAmt question edit to add insert marker
        @InKindPMVAmt = Question.find(:first, :conditions => ['name = ?',  'InKindPMVAmt']) 

        @InKindPMVAmt.update_attribute(:validation_message, "You can not enter an amount higher than the Presumed Maximum Value (PMV) of ~ for an individual or ~ for a couple on SSI.  Enter positive numbers only.  Do not enter $.") unless @InKindPMVAmt.blank?

        # calc to insert
         @RatePmvAmt  = WebCalc.find_by_name('RatePmvAmt')

         @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @InKindPMVAmt.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionValidationInsert.new(:question_id => @InKindPMVAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RatePmvAmt.id, :insert_marker => "~", :insert_type => 'currency')
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @InKindPMVAmt.id)
          @Insert1.update_attribute(:insert_number, '1')
          @Insert1.update_attribute(:webcalc_id_to_insert, @RatePmvAmt.id)
          @Insert1.update_attribute(:insert_marker, '~')
          @Insert1.update_attribute(:insert_type, 'currency')
         end
    
                 
         # calc to insert
          @RatePmvCoupleAmt  = WebCalc.find_by_name('RatePmvCoupleAmt')

          @Insert2 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @InKindPMVAmt.id, 2])
          if @Insert2.blank? then
             @Insert2  = QuestionValidationInsert.new(:question_id => @InKindPMVAmt.id, :insert_number => '2', :webcalc_id_to_insert => @RatePmvCoupleAmt.id, :insert_marker => "~", :insert_type => 'currency')
             @Insert2.save!
         else
           @Insert2.update_attribute(:question_id, @InKindPMVAmt.id)
           @Insert2.update_attribute(:insert_number, '2')
           @Insert2.update_attribute(:webcalc_id_to_insert, @RatePmvCoupleAmt.id)
           @Insert2.update_attribute(:insert_marker, '~')
           @Insert2.update_attribute(:insert_type, 'currency')
          end
  end

  def self.down
  end
end
