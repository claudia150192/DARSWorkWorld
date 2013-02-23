class UpdateQuestionSeieAmtForInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
       #25	134	How much of your monthly earnings ($SsiOrCaidEarnAmt) are excluded as a Student Earned Income Exclusion (SEIE)?	SeieAmt			Zero or Positive Number <= the smaller of ((RateSEIEMaxMonthly OR SsiOrCaidEarnAmt) 	Your Student Earned Income Exclusion (SE(E) can not be greater than the smaller of the maximum monthly  exclusion (RateSEIEMaxMonthly) or your monthly earned income (SsiOrCaidEarnAmt).  Enter positive numbers only.  Do not enter $.	EXPRESSION: the smaller of ((RateSEIEMaxMonthly OR SsiOrCaidEarnAmt) 	If Student = Y	no			139.00
                 
      #SeieAmt question edit to add insert marker
      @SeieAmt = Question.find(:first, :conditions => ['name = ?',  'SeieAmt']) 
      @SeieAmt.update_attribute(:text, "How much of your monthly earnings (~) are excluded as a Student Earned Income Exclusion (SEIE)?") 
      @SeieAmt.update_attribute(:validation_message, "Your Student Earned Income Exclusion (SEIE) can not be greater than the smaller of the maximum monthly exclusion or your monthly earned income.") 
      @SeieAmt.update_attribute(:reference_id, "134") 
      
     # calc to insert
     @RSsiOrCaidEarnAmt  = WebCalc.find_by_name('RSsiOrCaidEarnAmt')

     @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SeieAmt.id, 1])
     if @Insert2.blank? then
        @Insert2  = QuestionInsert.new(:question_id => @SeieAmt.id, :insert_number => '1', :webcalc_id_to_insert => @RSsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:question_id, @SeieAmt.id)
      @Insert2.update_attribute(:insert_number, '1')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RSsiOrCaidEarnAmt.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
  end

  def self.down
  end
end
