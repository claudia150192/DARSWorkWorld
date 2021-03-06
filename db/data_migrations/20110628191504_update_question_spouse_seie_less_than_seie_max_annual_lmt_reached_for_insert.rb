class UpdateQuestionSpouseSeieLessThanSeieMaxAnnualLmtReachedForInsert < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
       #27	144	Your spouse's SEIE exclusion ($SpouseSeieAmt) is less than the SEIE Monthly Maximum Exclusion ($RateSEIEMaxMonthly).  Has your spouse used up the SEIE annual exclusion amount ($RateSEIEMaxYear)?	
       #SpouseSeieLessThanSeieMaxAnnualLmtReached			YES:NO		YES	If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt > 0 AND (SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > Maximum Student Earned Income Exclusion (SEIE) per month AND SpouseSeieAmt < RateSEIEMaxMonthly)	no			150.00
                                      
      #SpouseSeieLessThanSeieMaxAnnualLmtReached question edit to add insert marker
      @SpouseSeieLessThanSeieMaxAnnualLmtReached = Question.find(:first, :conditions => ['name = ?',  'SpouseSeieLessThanSeieMaxAnnualLmtReached']) 
      @SpouseSeieLessThanSeieMaxAnnualLmtReached.update_attribute(:text, "Your spouse's SEIE exclusion (~) is less than the SEIE Monthly Maximum Exclusion (~).  Has your spouse used up the SEIE annual exclusion amount (~)?") 
      
     # calc to insert First of 3 inserts
     @Q_SpouseSeieAmt  = WebCalc.find_by_name('Q_SpouseSeieAmt')

     @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSeieLessThanSeieMaxAnnualLmtReached.id, 1])
     if @Insert1.blank? then
        @Insert1  = QuestionInsert.new(:question_id => @SpouseSeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SpouseSeieAmt.id, :insert_marker => "~", :insert_type => 'currency')
        @Insert1.save!
    else
      @Insert1.update_attribute(:question_id, @SpouseSeieLessThanSeieMaxAnnualLmtReached.id)
      @Insert1.update_attribute(:insert_number, '1')
      @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SpouseSeieAmt.id)
      @Insert1.update_attribute(:insert_marker, '~')
      @Insert1.update_attribute(:insert_type, 'currency')
     end
     
     # calc to insert 2nd of 3 inserts
      @RateSEIEMaxMonthly  = WebCalc.find_by_name('RateSEIEMaxMonthly')

      @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSeieLessThanSeieMaxAnnualLmtReached.id, 2])
      if @Insert2.blank? then
         @Insert2  = QuestionInsert.new(:question_id => @SpouseSeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '2', :webcalc_id_to_insert => @RateSEIEMaxMonthly.id, :insert_marker => "~", :insert_type => 'currency')
         @Insert2.save!
     else
       @Insert2.update_attribute(:question_id, @SpouseSeieLessThanSeieMaxAnnualLmtReached.id)
       @Insert2.update_attribute(:insert_number, '2')
       @Insert2.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxMonthly.id)
       @Insert2.update_attribute(:insert_marker, '~')
       @Insert2.update_attribute(:insert_type, 'currency')
      end
      
      # calc to insert 3rd of 3 inserts           RateSEIEMaxYear
        @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')

        @Insert3 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @SpouseSeieLessThanSeieMaxAnnualLmtReached.id, 3])
        if @Insert3.blank? then
           @Insert3  = QuestionInsert.new(:question_id => @SpouseSeieLessThanSeieMaxAnnualLmtReached.id, :insert_number => '3', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert3.save!
       else
         @Insert3.update_attribute(:question_id, @SpouseSeieLessThanSeieMaxAnnualLmtReached.id)
         @Insert3.update_attribute(:insert_number, '3')
         @Insert3.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
         @Insert3.update_attribute(:insert_marker, '~')
         @Insert3.update_attribute(:insert_type, 'currency')
        end
  end

  def self.down
  end
end
