class UpdateQuestionSubsidyWkDutiesReducAmtForValidation < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
          #25	162	What is the dollar value (per month) of any subsidy you get in for reduced work duties because of your disabiliy?	
          #SubsidyWkDutiesReducAmt			Zero or Positive Number <= DIEarnAmt	You can not enter an amount greater than the amount you earn (SsdiEarnAmt).  Enter positive numbers only.  Do not enter $.	0	IF TwpComplete = Y	Appear	500.00		168.00
          
          #SubsidyWkDutiesReducAmt question edit to add insert marker
          @SubsidyWkDutiesReducAmt = Question.find(:first, :conditions => ['name = ?',  'SubsidyWkDutiesReducAmt']) 

          @SubsidyWkDutiesReducAmt.update_attribute(:validation_message, "You can not enter an amount greater than the amount you earn (~).  Enter positive numbers only.  Do not enter $.") unless @SubsidyWkDutiesReducAmt.blank?

          # calc to insert
           @RSsdiEarnAmt  = WebCalc.find_by_name('RSsdiEarnAmt')

           @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SubsidyWkDutiesReducAmt.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionValidationInsert.new(:question_id => @SubsidyWkDutiesReducAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSsdiEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @SubsidyWkDutiesReducAmt.id)
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RSsdiEarnAmt.id)
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end

  end

  def self.down
  end
end
