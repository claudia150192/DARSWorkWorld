class UpdateQuestionCoupleSeieLessThanSeieMaxAnnualLmtReachedForInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
         #27	141	The sum of your SEIE exclusion ($SeieAmt) and your spouse's ($SpouseSeieAmt) is less than the SEIE Monthly Maximum ($RateSEIEMaxMonthly).  Have you and your spouse used up your SEIE annual exclusion amount ($RateSEIEMaxYear)?	
         #CoupleSeieLessThanSeieMaxAnnualLmtReached			YES:NO		YES	If (Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt > 0 AND (SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > Maximum Student Earned Income Exclusion (SEIE) per month AND (SeieAmt + SpouseSeieAmt) < (RateSEIEMaxMonthly)	no			147.00
         
        #CoupleSeieLessThanSeieMaxAnnualLmtReached question edit to add insert marker
        @CoupleSeieLessThanSeieMaxAnnualLmtReached = Question.find(:first, :conditions => ['name = ?',  'CoupleSeieLessThanSeieMaxAnnualLmtReached']) 
        @CoupleSeieLessThanSeieMaxAnnualLmtReached.update_attribute(:text, "The sum of your SEIE exclusion (~) and your spouse's (~) is less than the SEIE Monthly Maximum (~).  Have you and your spouse used up your SEIE annual exclusion amount (~)?") 

       # calc to insert First of 4 inserts
       @Q_SeieAmt  = WebCalc.find_by_name('Q_SeieAmt')

       @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanSeieMaxAnnualLmtReached.id, 1])
       if @Insert1.blank? then
          @Insert1  = QuestionInsert.new(:question_id => @CoupleSeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SeieAmt.id, :insert_marker => "~", :insert_type => 'currency')
          @Insert1.save!
      else
        @Insert1.update_attribute(:question_id, @CoupleSeieLessThanSeieMaxAnnualLmtReached.id)
        @Insert1.update_attribute(:insert_number, '1')
        @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SeieAmt.id)
        @Insert1.update_attribute(:insert_marker, '~')
        @Insert1.update_attribute(:insert_type, 'currency')
       end

       # calc to insert 2nd of 4 inserts
         @Q_SpouseSeieAmt  = WebCalc.find_by_name('Q_SpouseSeieAmt')

         @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanSeieMaxAnnualLmtReached.id, 2])
         if @Insert2.blank? then
            @Insert2  = QuestionInsert.new(:question_id => @CoupleSeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '2', :webcalc_id_to_insert => @Q_SpouseSeieAmt.id, :insert_marker => "~", :insert_type => 'currency')
            @Insert2.save!
        else
          @Insert2.update_attribute(:question_id, @CoupleSeieLessThanSeieMaxAnnualLmtReached.id)
          @Insert2.update_attribute(:insert_number, '2')
          @Insert2.update_attribute(:webcalc_id_to_insert, @Q_SpouseSeieAmt.id)
          @Insert2.update_attribute(:insert_marker, '~')
          @Insert2.update_attribute(:insert_type, 'currency')
         end

       # calc to insert 3nd of 4 inserts
        @RateSEIEMaxMonthly  = WebCalc.find_by_name('RateSEIEMaxMonthly')

        @Insert3 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanSeieMaxAnnualLmtReached.id, 3])
        if @Insert3.blank? then
           @Insert3  = QuestionInsert.new(:question_id => @CoupleSeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '3', :webcalc_id_to_insert => @RateSEIEMaxMonthly.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert3.save!
       else
         @Insert3.update_attribute(:question_id, @CoupleSeieLessThanSeieMaxAnnualLmtReached.id)
         @Insert3.update_attribute(:insert_number, '3')
         @Insert3.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxMonthly.id)
         @Insert3.update_attribute(:insert_marker, '~')
         @Insert3.update_attribute(:insert_type, 'currency')
        end
          
     # calc to insert 4th of 4 inserts           
       @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')
 
       @Insert4 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanSeieMaxAnnualLmtReached.id, 4])
       if @Insert4.blank? then
          @Insert4  = QuestionInsert.new(:question_id => @CoupleSeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '4', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
          @Insert4.save!
      else
        @Insert4.update_attribute(:question_id, @CoupleSeieLessThanSeieMaxAnnualLmtReached.id)
        @Insert4.update_attribute(:insert_number, '4')
        @Insert4.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
        @Insert4.update_attribute(:insert_marker, '~')
        @Insert4.update_attribute(:insert_type, 'currency')
       end
       
  end

  def self.down
  end
end
