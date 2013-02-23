class UpdateQuestionSubsidyEmpSupAmtForValidation < ActiveRecord::Migration
  def self.up
    
        require 'wwweb_session_manager'  
           #25	161	What is the dollar value (per month) of any subsidy you get for additonal supervision or special conditions provided to you because of your disability?	SubsidyEmpSupAmt			Zero or Positive Number <= SsdiEarnAmt	
           #You can not enter an amount greater than the amount you earn (SsdiEarnAmt).  Enter positive numbers only.  Do not enter $.	0	IF TwpComplete = Y	Appear	0.00	We ask these questions only if TWP completed and earnings are over SGA.  And we only ask if there is a subsidy, not the two-step questions in WW.	167.00
           
          #SubsidyEmpSupAmt question edit to add insert marker
          @SubsidyEmpSupAmt = Question.find(:first, :conditions => ['name = ?',  'SubsidyEmpSupAmt']) 

          @SubsidyEmpSupAmt.update_attribute(:validation_message, "You can not enter an amount greater than the amount you earn (~).  Enter positive numbers only.  Do not enter $.") unless @SubsidyEmpSupAmt.blank?

          # calc to insert
           @RSsdiEarnAmt  = WebCalc.find_by_name('RSsdiEarnAmt')

           @Insert1 = QuestionValidationInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SubsidyEmpSupAmt.id, 1])
           if @Insert1.blank? then
              @Insert1  = QuestionValidationInsert.new(:question_id => @SubsidyEmpSupAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSsdiEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
              @Insert1.save!
          else
            @Insert1.update_attribute(:question_id, @SubsidyEmpSupAmt.id)
            @Insert1.update_attribute(:insert_number, '1')
            @Insert1.update_attribute(:webcalc_id_to_insert, @RSsdiEarnAmt.id)
            @Insert1.update_attribute(:insert_marker, '~')
            @Insert1.update_attribute(:insert_type, 'currency')
           end

  end

  def self.down
  end
end
