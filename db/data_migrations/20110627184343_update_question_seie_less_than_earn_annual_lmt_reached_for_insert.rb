class UpdateQuestionSeieLessThanEarnAnnualLmtReachedForInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
       #25	137	Your SEIE exclusion ($SeieAmt) is less than your earnings ($SsiOrCaidEarnAmt).  Have you used up your SEIE annual exclusion amount ($6600)?	SeieLessThanEarnAnnualLmtReached			YES:NO		YES	If Student = Y AND SpouseStudent <> Y AND SeieAmt > 0 AND SsiOrCaidEarnAmt <  RateSEIEMaxMonthly  AND SeieAmt < SsiOrCaidEarnAmt	no		This and the next 8 questions are to check if user is entering correct SEIE.  If the SEIE amount is less then either the earnings amount or the monthly SEIE max (whichever is smaller), then a Text Result will appear unless the user has used up the SEIE annual exclusion.  It will tell user that user cannot spread out SEIE by including less than the full possible amount.	143.00
                        
      #SeieLessThanEarnAnnualLmtReached question edit to add insert marker
      @SeieLessThanEarnAnnualLmtReached = Question.find(:first, :conditions => ['name = ?',  'SeieLessThanEarnAnnualLmtReached']) 
      @SeieLessThanEarnAnnualLmtReached.update_attribute(:text, "Your SEIE exclusion (~) is less than your earnings (~).  Have you used up your SEIE annual exclusion amount (~)?") 
      
     # calc to insert First of 3 inserts
     @Q_SeieAmt  = WebCalc.find_by_name('Q_SeieAmt')

     @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SeieLessThanEarnAnnualLmtReached.id, 1])
     if @Insert1.blank? then
        @Insert1  = QuestionInsert.new(:question_id => @SeieLessThanEarnAnnualLmtReached.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SeieAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:question_id, @SeieLessThanEarnAnnualLmtReached.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SeieAmt.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end
     
     # calc to insert 2nd of 3 inserts
      @Q_SsiOrCaidEarnAmt  = WebCalc.find_by_name('Q_SsiOrCaidEarnAmt')

      @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SeieLessThanEarnAnnualLmtReached.id, 2])
      if @Insert2.blank? then
         @Insert2  = QuestionInsert.new(:question_id => @SeieLessThanEarnAnnualLmtReached.id, :insert_number => '2', :webcalc_id_to_insert => @Q_SsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
         @Insert2.save!
     else
       @Insert2.update_attribute(:question_id, @SeieLessThanEarnAnnualLmtReached.id)
       @Insert2.update_attribute(:insert_number, '2')
       @Insert2.update_attribute(:webcalc_id_to_insert, @Q_SsiOrCaidEarnAmt.id)
       @Insert2.update_attribute(:insert_marker, '~')
       @Insert2.update_attribute(:insert_type, 'currency')
      end
      
      # calc to insert 3rd of 3 inserts
        @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')

        @Insert3 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SeieLessThanEarnAnnualLmtReached.id, 3])
        if @Insert3.blank? then
           @Insert3  = QuestionInsert.new(:question_id => @SeieLessThanEarnAnnualLmtReached.id, :insert_number => '3', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert3.save!
       else
         @Insert3.update_attribute(:question_id, @SeieLessThanEarnAnnualLmtReached.id)
         @Insert3.update_attribute(:insert_number, '3')
         @Insert3.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
         @Insert3.update_attribute(:insert_marker, '~')
         @Insert3.update_attribute(:insert_type, 'currency')
        end
  end

  def self.down
  end
end
