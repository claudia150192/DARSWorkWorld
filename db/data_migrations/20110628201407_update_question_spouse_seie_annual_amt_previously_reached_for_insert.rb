class UpdateQuestionSpouseSeieAnnualAmtPreviouslyReachedForInsert < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
       #27	145	Your spouse has no SEIE excluded income. Has your spouse already excluded in this calendar year enough earnings to reach the maximum annual SEIE limit ($RateSEIEMaxYear)?	SpouseSeieAnnualAmtPreviouslyReached			YES:NO		YES	If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt = 0 AND (SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > 0	no			151.00

      #SpouseSeieAnnualAmtPreviouslyReached question edit to add insert marker
      @SpouseSeieAnnualAmtPreviouslyReached = Question.find(:first, :conditions => ['name = ?',  'SpouseSeieAnnualAmtPreviouslyReached']) 
      @SpouseSeieAnnualAmtPreviouslyReached.update_attribute(:text, "Your spouse has no SEIE excluded income. Has your spouse already excluded in this calendar year enough earnings to reach the maximum annual SEIE limit (~)?") 
      
     # calc to insert
     @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')

     @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSeieAnnualAmtPreviouslyReached.id, 1])
     if @Insert2.blank? then
        @Insert2  = QuestionInsert.new(:question_id => @SpouseSeieAnnualAmtPreviouslyReached.id, :insert_number => '1', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert2.save!
    else
      @Insert2.update_attribute(:question_id, @SpouseSeieAnnualAmtPreviouslyReached.id)
      @Insert2.update_attribute(:insert_number, '1')
      @Insert2.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
      @Insert2.update_attribute(:insert_marker, '~')
      @Insert2.update_attribute(:insert_type, 'currency')
     end
  end

  def self.down
  end
end
