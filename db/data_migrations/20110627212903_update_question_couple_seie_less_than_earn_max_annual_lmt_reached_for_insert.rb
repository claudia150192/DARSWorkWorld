class UpdateQuestionCoupleSeieLessThanEarnMaxAnnualLmtReachedForInsert < ActiveRecord::Migration
  def self.up
     require 'wwweb_session_manager'  
         #27	140	The sum of your SEIE exclusion ($SeieAmt) and your spouse's ($SpouseSeieAmt) is less than the sum of your earnings ($SsiOrCaidEarnAmt) and your spouse's ($SpouseSsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt).  Have you and your spouse used up your SEIE annual exclusion amount ($RateSEIEMaxYear)?	
         #CoupleSeieLessThanEarnMaxAnnualLmtReached			YES:NO		YES	If (Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt > 0 AND (SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) < RateSEIEMaxMonthly AND (SeieAmt + SpouseSeieAmt) < (SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt)	no		Should appear when student and/or spouse claim SEIE that is less than the couple should be claiming according to the monthly rule.  It is a check that student is not trying to spread out earnings by claiming less than the full amount that can be claimed.  It must work even if user is not a student and spouse does not get SSI (but deems income to user)	146.00
         
        #CoupleSeieLessThanEarnMaxAnnualLmtReached question edit to add insert marker
        @CoupleSeieLessThanEarnMaxAnnualLmtReached = Question.find(:first, :conditions => ['name = ?',  'CoupleSeieLessThanEarnMaxAnnualLmtReached']) 
        @CoupleSeieLessThanEarnMaxAnnualLmtReached.update_attribute(:text, "The sum of your SEIE exclusion (~) and your spouse's (~) is less than the sum of your earnings (~) and your spouse's (~).  Have you and your spouse used up your SEIE annual exclusion amount (~)?") 

       # calc to insert First of 5 inserts
       @Q_SeieAmt  = WebCalc.find_by_name('Q_SeieAmt')

       @Insert1 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, 1])
       if @Insert1.blank? then
          @Insert1  = QuestionInsert.new(:question_id => @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, :insert_number => '1', :webcalc_id_to_insert => @Q_SeieAmt.id, :insert_marker => "~", :insert_type => 'currency')
          @Insert1.save!
      else
        @Insert1.update_attribute(:question_id, @CoupleSeieLessThanEarnMaxAnnualLmtReached.id)
        @Insert1.update_attribute(:insert_number, '1')
        @Insert1.update_attribute(:webcalc_id_to_insert, @Q_SeieAmt.id)
        @Insert1.update_attribute(:insert_marker, '~')
        @Insert1.update_attribute(:insert_type, 'currency')
       end

       # calc to insert 2nd of 5 inserts
         @Q_SpouseSeieAmt  = WebCalc.find_by_name('Q_SpouseSeieAmt')

         @Insert2 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, 2])
         if @Insert2.blank? then
            @Insert2  = QuestionInsert.new(:question_id => @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, :insert_number => '2', :webcalc_id_to_insert => @Q_SpouseSeieAmt.id, :insert_marker => "~", :insert_type => 'currency')
            @Insert2.save!
        else
          @Insert2.update_attribute(:question_id, @CoupleSeieLessThanEarnMaxAnnualLmtReached.id)
          @Insert2.update_attribute(:insert_number, '2')
          @Insert2.update_attribute(:webcalc_id_to_insert, @Q_SpouseSeieAmt.id)
          @Insert2.update_attribute(:insert_marker, '~')
          @Insert2.update_attribute(:insert_type, 'currency')
         end

       # calc to insert 3nd of 5 inserts
        @RSsiOrCaidEarnAmt  = WebCalc.find_by_name('RSsiOrCaidEarnAmt')

        @Insert3 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, 3])
        if @Insert3.blank? then
           @Insert3  = QuestionInsert.new(:question_id => @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, :insert_number => '3', :webcalc_id_to_insert => @RSsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
           @Insert3.save!
       else
         @Insert3.update_attribute(:question_id, @CoupleSeieLessThanEarnMaxAnnualLmtReached.id)
         @Insert3.update_attribute(:insert_number, '3')
         @Insert3.update_attribute(:webcalc_id_to_insert, @RSsiOrCaidEarnAmt.id)
         @Insert3.update_attribute(:insert_marker, '~')
         @Insert3.update_attribute(:insert_type, 'currency')
        end

        # calc to insert 4th of 5 inserts           
          @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt  = WebCalc.find_by_name('Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt')

          @Insert4 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, 4])
          if @Insert4.blank? then
             @Insert4  = QuestionInsert.new(:question_id => @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, :insert_number => '4', :webcalc_id_to_insert => @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.id, :insert_marker => "~", :insert_type => 'currency')
             @Insert4.save!
         else
           @Insert4.update_attribute(:question_id, @CoupleSeieLessThanEarnMaxAnnualLmtReached.id)
           @Insert4.update_attribute(:insert_number, '4')
           @Insert4.update_attribute(:webcalc_id_to_insert, @Q_SpouseWhoIsDeemedEarnAmtPlusSpouseSsiOrCaidEarnAmt.id)
           @Insert4.update_attribute(:insert_marker, '~')
           @Insert4.update_attribute(:insert_type, 'currency')
          end
          
          # calc to insert 5th of 5 inserts           
            @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')

            @Insert5 = QuestionInsert.find(:first, :conditions => ['question_id = ? AND insert_number = ?',  @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, 5])
            if @Insert5.blank? then
               @Insert5  = QuestionInsert.new(:question_id => @CoupleSeieLessThanEarnMaxAnnualLmtReached.id, :insert_number => '5', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
               @Insert5.save!
           else
             @Insert5.update_attribute(:question_id, @CoupleSeieLessThanEarnMaxAnnualLmtReached.id)
             @Insert5.update_attribute(:insert_number, '5')
             @Insert5.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
             @Insert5.update_attribute(:insert_marker, '~')
             @Insert5.update_attribute(:insert_type, 'currency')
            end
  end

  def self.down
  end
end
