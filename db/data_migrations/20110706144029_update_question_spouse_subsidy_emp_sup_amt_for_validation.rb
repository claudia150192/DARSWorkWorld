class UpdateQuestionSpouseSubsidyEmpSupAmtForValidation < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
          #25	163	What is the dollar value (per month) of any subsidy your spouse gets for additonal supervision or special conditions provided because of your spouse's disability?	
          #SpouseSubsidyEmpSupAmt			Zero or Positive Number <= SpouseSsdiEarnAmt	You can not enter an amount greater than the amount your spouse earns (SpouseSsdiEarnAmt).  Enter positive numbers only.  Do not enter $.	0	IF SpouseTwpComplete = Y	no	0.00		169.00
          
          #SpouseSubsidyEmpSupAmt question edit to add insert marker
          @SpouseSubsidyEmpSupAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSubsidyEmpSupAmt']) 

          @SpouseSubsidyEmpSupAmt.update_attribute(:validation_message, "You can not enter an amount greater than the amount your spouse earns (~).  Enter positive numbers only.  Do not enter $.") unless @SpouseSubsidyEmpSupAmt.blank?

          # calc to insert
           @RSpouseSsdiEarnAmt  = WebCalc.find_by_name('RSpouseSsdiEarnAmt')

           @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSubsidyEmpSupAmt.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionValidationInsert.new(:question_id => @SpouseSubsidyEmpSupAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSpouseSsdiEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @SpouseSubsidyEmpSupAmt.id)
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RSpouseSsdiEarnAmt.id)
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end

  end

  def self.down
  end
end
