class UpdateQuestionSeieAnnualLmtPreviouslyReachedForInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
       #25	139	You have no SEIE excluded income. Have you already excluded in this calendar year enough earnings to reach the maximum annual SEIE limit ($RateSEIEMaxYear)?	SeieAnnualLmtPreviouslyReached			YES:NO		YES	If Student = Y AND SpouseStudent <> Y AND SsiOrCaidEarnAmt > 0 AND SeieAmt = 0	no		Appear when a student (who does not have a student spouse with earnings) who is otherwise eligible for SEIE does not get the exclusion.  It will trigger an Alert about using the SEIE unless the annual amount has been used up.	145.00

      #SeieAnnualLmtPreviouslyReached question edit to add insert marker
      @SeieAnnualLmtPreviouslyReached = Question.find(:first, :conditions => ['name = ?',  'SeieAnnualLmtPreviouslyReached']) 
      @SeieAnnualLmtPreviouslyReached.update_attribute(:text, "You have no SEIE excluded income. Have you already excluded in this calendar year enough earnings to reach the maximum annual SEIE limit (~)?") 
      
     # calc to insert
     @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')

     @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SeieAnnualLmtPreviouslyReached.id, 1])
     if @Insert2.blank? then
        @Insert2  = QuestionInsert.new(:question_id => @SeieAnnualLmtPreviouslyReached.id, :insert_number => '1', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:question_id, @SeieAnnualLmtPreviouslyReached.id)
      @Insert2.update_attribute(:insert_number, '1')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
  end

  def self.down
  end
end
