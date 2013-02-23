class UpdateQuestionUnearnInfrequentAmtForValidation < ActiveRecord::Migration
  def self.up
   
      require 'wwweb_session_manager'  
         #30 31	91	How much of your ~$UnearnAmt~ of unearned income is infrequent or irregular?	
         #UnearnInfrequentAmt			Zero or Positive Number <= UnearnAmt	
         #You can not enter an amount higher than your unearned income, not counting SSDI or SSI (UnearnAmt).  Enter positive numbers only.  Do not enter $.	0	IF UnearnAmt > 0 AND (SsiGet = Y OR CaidGet = Y OR CaidApply = Y)	Appear	25.00	For SSI, this amount can be up to $60 per calendar quarter. (See POMS SI 00810.410 J)  FOR MEDICAID, A TIP should say that if the exclusion If it is over $20, then nothing is excluded.  (See M0810.410)	96.00
         
        #UnearnInfrequentAmt question edit to add insert marker
        @UnearnInfrequentAmt = Question.find(:first, :conditions => ['name = ?',  'UnearnInfrequentAmt']) 

        @UnearnInfrequentAmt.update_attribute(:validation_message, "You can not enter an amount higher than your unearned income, not counting SSDI or SSI (~).  Enter positive numbers only.  Do not enter $.") unless @UnearnInfrequentAmt.blank?

        # calc to insert
         @RUnearnAmt  = WebCalc.find_by_name('RUnearnAmt')

         @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @UnearnInfrequentAmt.id, 1])
         if @Insert1.blank? then
            @Insert1  = QuestionValidationInsert.new(:question_id => @UnearnInfrequentAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RUnearnAmt.id, :insert_marker => "~", :insert_type => 'currency')
            @Insert1.save!
        else
          @Insert1.update_attribute(:question_id, @UnearnInfrequentAmt.id)
          @Insert1.update_attribute(:insert_number, '1')
          @Insert1.update_attribute(:webcalc_id_to_insert, @RUnearnAmt.id)
          @Insert1.update_attribute(:insert_marker, '~')
          @Insert1.update_attribute(:insert_type, 'currency')
         end
  end

  def self.down
  end
end
